# -*- coding: utf-8 -*-

module Xinge
  class Base

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
          message_type: 1
          })
        send_request('push', 'single_device', params)
      end

      protected

      def send_request(type, method, params = {})
        request_path = get_request_url(type, method)
        params.merge!({access_id: Settings.xinge_access_id, timestamp: Time.now.to_i})

        # sort params and calculate sign
        params_string = params.sort.map{ |h| h.join('=') }.join
        sign_str = "POST#{Settings.xinge_host}#{request_path}#{params_string}#{Settings.xinge_secret_key}"
        sign = Digest::MD5.hexdigest(sign_str)
        params.merge!({ sign: sign })

        begin
          logger.info "xinge start push: #{params}"
          request_url = "#{Settings.xinge_api_url}#{request_path}"
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
        "/v2/#{type}/#{method}"
      end

    end

  end
end