# == Schema Information
#
# Table name: user_devices
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  device_type  :string(255)
#  device_id    :string(255)
#  device_token :string(255)
#  created_at :datetime
#  updated_at :datetime

class UserDevice < ActiveRecord::Base
  belongs_to :user

  IOS = 'ios'
  ANDROID = 'android'

  def is_ios?
    device_type.present? && device_type == UserDevice::IOS
  end

  class << self

    def notification_device(user_id)
      where(user_id: user_id).order("updated_at desc").first
    end

    def register_device_token(user_id, device_token)
      device = where(user_id: user_id, device_token: device_token).first
      if device.present?
        device.touch
      else
        create(user_id: user_id, device_token: device_token,
          device_type: UserDevice::IOS)
      end
    end

  end

end
