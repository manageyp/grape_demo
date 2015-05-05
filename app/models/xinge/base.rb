# -*- coding: utf-8 -*-

module Xinge
  class Base

    XINGE_HOST = 'openapi.xg.qq.com'
    XINGE_HOST_URI = 'http://openapi.xg.qq.com'
    XINGE_API_VERSION = 'v2'
    XINGE_ACCESS_ID = Settings.xinge_access_id
    XINGE_SECRET_KEY = Settings.xinge_secret_key
    XINGE_HTTP_METHOD = :post
    XINGE_MESSAGE_TYPE = 1

    class << self

      def logger
        Yell.new do |l|
          l.adapter :datefile, "#{Settings.log_path}/push.log", level: 'gte.info'
        end
      end

      # push 消息（包括通知和透传消息）给单个设备
      def push_single_device(device_token, message, params = {})
        params.merge!({
          device_token: device_token,
          message: message,
          message_type: XINGE_MESSAGE_TYPE
          })
        send_request('push', 'single_device', params)
      end

      protected

      def send_request(type, method, params = {})
        request_path = get_request_url(type, method)
        params.merge!({access_id: XINGE_ACCESS_ID, timestamp: Time.now.to_i})

        # sort params and calculate sign
        params_string = params.sort.map{ |h| h.join('=') }.join
        sign_str = "POST#{XINGE_HOST}#{request_path}#{params_string}#{XINGE_SECRET_KEY}"
        sign = Digest::MD5.hexdigest(sign_str)
        params.merge!({ sign: sign })

        begin
          logger.info "xinge start push: #{params}"
          request_url = "#{XINGE_HOST_URI}#{request_path}"
          reuqest_header = {'Content-Type' => 'application/x-www-form-urlencoded'}
          response = RestClient.post(request_url, params, reuqest_header)
          if response.present?
            result = JSON.parse(response)
            logger.info "xinge end push: #{result}"
            if result
              [result["ret_code"], result["err_msg"]]
            end
          end
        rescue => e
          puts e.response
          return false
        end
      end

      def get_request_url(type, method)
        "/#{XINGE_API_VERSION}/#{type}/#{method}"
      end

    end

  end
end