require "active_support/core_ext/object/try"
require "mem"
require "twitter"
require "tweetstream"

module Ruboty
  module Adapters
    class TwitterDirectMessage < Base
      include Mem

      env :TWITTER_ACCESS_TOKEN, "Twitter access token"
      env :TWITTER_ACCESS_TOKEN_SECRET, "Twitter access token secret"
      env :TWITTER_CONSUMER_KEY, "Twitter consumer key (a.k.a. API key)"
      env :TWITTER_CONSUMER_SECRET, "Twitter consumer secret (a.k.a. API secret)"

      def run
        Ruboty.logger.debug("#{self.class}##{__method__} started")
        abortable
        listen
        Ruboty.logger.debug("#{self.class}##{__method__} finished")
      end

      def say(message)
        client.update(message[:body], in_reply_to_status_id: message[:original][:tweet].try(:id))
      end

      private

      def enabled_to_auto_follow_back?
        ENV["TWITTER_AUTO_FOLLOW_BACK"] == "1"
      end

      def listen
        stream.on_direct_message do |direct_message|
          Ruboty.logger.debug("#{direct_message.sender.screen_name} send direct message #{direct_message.text.inspect}")
          robot.receive(
            body: direct_message.text,
            from: direct_message.sender.screen_name,
            tweet: direct_message
          )
        end
        stream.userstream
      end

      def client
        ::Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
          config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
          config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
          config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
        end
      end
      memoize :client

      def stream
        ::TweetStream::Client.new(
          consumer_key: ENV["TWITTER_CONSUMER_KEY"],
          consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
          oauth_token: ENV["TWITTER_ACCESS_TOKEN"],
          oauth_token_secret: ENV["TWITTER_ACCESS_TOKEN_SECRET"],
          auth_method: :oauth
        )
      end
      memoize :stream

      def abortable
        Thread.abort_on_exception = true
      end
    end
  end
end
