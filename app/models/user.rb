# -*- encoding : utf-8 -*-

# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  user_name     :string(255)
#  email         :string(255)
#  email_status  :string(255)
#  cellphone     :string(255)
#  cellphone_status     :string(255)
#  register_date :date
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base

  attr_accessible :cellphone, :cellphone_status, :email, :email_status,
                  :register_date, :status, :user_name

  class << self

  end

end
