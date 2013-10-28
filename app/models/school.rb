# -*- encoding : utf-8 -*-

# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  detail_type :string(255)      not null
#  detail_id   :integer          not null
#  country_id  :integer
#  province_id :integer
#  city_id     :integer
#  nick_name   :string(255)
#  real_name   :string(255)
#  web_site    :string(255)
#  found_year  :string(255)
#  ifeng_code  :string(255)
#  address     :string(255)
#  telephone   :string(255)
#  sina_code   :string(255)
#  latitude     :string(255)
#  longitude   :string(255)
#  zipcode   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class School < ActiveRecord::Base

  attr_accessible :country_id, :province_id, :city_id,
                  :nick_name, :real_name, :web_site,
                  :found_year, :ifeng_code, :address,
                  :telephone, :sina_code, :latitude,
                  :longitude, :zipcode, :status

  ModelName = "学校"
  ColumnNames = {
    country_id: "所在国家",
    province_id: "所在省份",
    city_id: "所在城市",
    nick_name: "别名",
    real_name: "真名",
    web_site: "网址",
    found_year: "创建年份",
    address: "地址",
    telephone: "联系电话",
    latitude: "纬度",
    longitude: "经度",
    zipcode: "邮政编码"
  }

  class << self

    def paginate(page)
      per_page = 20
      page = page.to_i <= 0 ? 1 : page.to_i
      order("id").page(page).per(per_page)
    end

  end

end