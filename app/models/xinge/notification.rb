# -*- coding: utf-8 -*-

module Xinge
  class Notification

    class << self

      def reply_push(reply_id)
        reply = Reply.where(id: reply_id).first
        if reply.present?
          content = "#{reply.to_user.name}: 对您发表了新的评论，快去看看吧~"
          do_push(reply.to_user_id, content)
        end
      end

      def do_push(user_id, content)
        title = "APP名称"
        device = UserDevice.notification_device(user_id)
        if device.present?
          if device.is_ios?
            Xinge::Ios.push_to_single_device(device.device_token, title, content)
          else
            Xinge::Android.push_to_single_device(device.device_token, title, content)
          end
        end
      end

    end

  end
end