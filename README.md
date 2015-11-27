# Ruboty::TwitterDirectMessage [![Gem Version](https://badge.fury.io/rb/ruboty-twitter_direct_message.svg)](https://badge.fury.io/rb/ruboty-twitter_direct_message)
An [Ruboty](https://github.com/r7kamura/ruboty) adapter for twitter user-stream API.
Cloned from [r7kamura/ruboty-twitter](https://github.com/r7kamura/ruboty-twitter)

## Usage
```ruby
# Gemfile
gem "ruboty-twitter_direct_message"
```

## ENV
```
TWITTER_ACCESS_TOKEN           - Twitter access token
TWITTER_ACCESS_TOKEN_SECRET    - Twitter access token secret
TWITTER_CONSUMER_KEY           - Twitter consumer key (a.k.a. API key)
TWITTER_CONSUMER_SECRET        - Twitter consumer secret (a.k.a. API secret)
```

## Attention
Handler need `{all: true}`

```ruby
module Ruboty
  module Handlers
    class Ping < Base
      on(
        /ping/,
        name: "ping",
        all: true
      )

      def ping(message)
        message.reply("pong")
      end
    end
  end
end
```
