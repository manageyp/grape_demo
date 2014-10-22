# -*- encoding : utf-8 -*-

module Util
  module GrapeCache
    extend ActiveSupport::Concern

    def compare_etag(etag)
      etag_key = ActiveSupport::Cache.expand_cache_key(etag)
      etag_value = Digest::MD5.hexdigest(etag_key)

      error!("Not Modified", 304) if request.headers["If-None-Match"] == etag_value

      header "ETag", %("#{etag_value}")
    end

    # Based on actionpack/lib/action_controller/base.rb, line 1216
    def expires_in(seconds, options = {})
      cache_control = []
      if seconds == 0
        cache_control << "no-cache"
      else
        cache_control << "max-age=#{seconds}"
      end

      if options[:public]
        cache_control << "public"
      else
        cache_control << "private"
      end

      # This allows for additional headers to be passed through like 'max-stale' => 5.hours
      cache_control += options.symbolize_keys.reject{|k,v| k == :public || k == :private }.map{ |k,v| v == true ? k.to_s : "#{k.to_s}=#{v.to_s}"}

      header "Cache-Control", cache_control.join(', ')
    end

    def default_expire_time
      2.hours
    end

    def set_grape_cache(opts = {})
      # Set Cache-Control
      expires_in(opts[:expires_in] || default_expire_time, public: true)

      if opts[:etag]
        compare_etag(opts[:etag]) # Check if client has fresh version
      end
    end

  end
end
