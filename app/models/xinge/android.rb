# -*- coding: utf-8 -*-

module Xinge
  class Android < Base

    class << self

      def push_to_single_device(device_token, title, content)
        push_single_device(device_token, build_simple_message(title, content))
      end

      protected

      def build_simple_message(title, content)
        { title: title, content: content, vibrate: 1 }.to_json
      end

    end

  end
end