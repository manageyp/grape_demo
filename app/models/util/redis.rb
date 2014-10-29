# -*- encoding : utf-8 -*-

module Util
  module Redis

    class << self

      def get(key)
        $redis.get(key)
      end

      def setex(key, value, ttl=30*24*3600)
        $redis.setex(key, ttl, value)
      end

      def expire(key, ttl=30*24*3600)
        $redis.expire(key, ttl)
      end

    end

  end
end