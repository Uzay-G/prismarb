# Prismarb

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/prismarb`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prismarb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install prismarb

## Usage

Setup a new bot at https://prismalytics.herokuapp.com and copy its bot token.

Require the gem in your code:

```ruby
require "prismarb"
```

Initialize the connection with the library using your secret key:

```
analytics = Prismarb::Prismalytics.new("IjGMCkmcvcTFoHAACx2ssg")
```

Then, whenever your bot gets sent a message with its prefix. So, for example:

```ruby
require 'discordrb'
require 'prismarb'
bot = Discordrb::Bot.new token: 'NzA2OTA0NjMzNjk1NjY2MTc3.XsQS0Q.zJ3QaejYl7_4Fv7fmsZFLle5wYU'
analytics = Prismarb::Prismalytics.new("IjGMCkmcvcTFoHAACx2ssg")
puts "This bot's invite URL is sdsds"
puts 'Click on it to invite it to your server.'

bot.message(content: '~Ping!') do |event|
  event.respond 'Pong!'
  analytics.send(event.message)
end
bot.run
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
