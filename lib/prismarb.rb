require 'net/http'
require 'uri'
module Prismarb
  class Error < StandardError; end

  class Prismalytics
      
    def initialize(key)
        @key = key
        @commands = {}
        @servers = []
        @time = nil
    end

    def process_data(message, server)
      message = message.content.split(" ")[0]
      if @commands.has_key? message
          self.commands[message] += 1
      else
          self.commands[message] = 1
      end

      match = @servers.find { |i| i["name"] == server.name }
      
      if match.nil?
          new_server = {
              "name": server.name,
              "member_count": server.member_count,
              "region": server.region,
              "bot_messages": 1
              }
          @servers << new_server
      else
          match["bot_messages"] += 1
      end
    end
        
    def send(message)
      """
      processes data and sends every 2 minutes
      TODO: refactor so that users don't need to use ctx
      """
      unset = False
      if @time.nil?
          @time = Time.now
          unset = True
      end
      server = message.guild
      self.process_data(message, server)
      

      curr_time = Time.now
      interval = (curr_time - @time) / 60
      if (unset or interval > 5)
          @time = curr_time
          data = {
              "commands":  self.commands,
              "save_server": self.save_server,
              "servers": self.servers
              }

          Net::HTTP.post URI('https://prismalytics.herokuapp.com/send_data'),
                        data.to_json,
                        "key" => @key

          # reinitialize stored data as it has been sent
          @commands = {}
          @servers = []
      end
    end
  end
end
