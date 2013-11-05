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
  include Tire::Model::Search
  attr_accessor :location
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

  PER_PAGE = 20

  class << self

    def paginate(page)
      page = page.to_i <= 0 ? 1 : page.to_i
      order("id").page(page).per(PER_PAGE)
    end

    def search(params)
      lng = params[:lng].to_f
      lat = params[:lat].to_f
      params[:per_page] ||= PER_PAGE
      tire.search(page: params[:page], per_page: params[:per_page], load: true) do
        query do
          boolean do
            #must { string params[:keyword], default_operator: "AND" } if params[:keyword].present?
            must { match [:name], params[:keyword] } if params[:keyword].present?
            must { term :city_id, params[:city_id] } if params[:city_id].present? && params[:city_id].to_i > 0
          end
        end
        if params[:lat].to_f != 0 && params[:lng].to_f != 0
          sort do
            by :_geo_distance, { location: [lng, lat], order: "asc", unit: 'km' }
          end
        end
      end
    end

  end

  def location
    { lon: longitude.to_f, lat: latitude.to_f }
  end

  self.include_root_in_json = false
  def to_indexed_json
    { id: id,
      name: real_name,
      nick_name: nick_name,
      location: location,
      city_id: city_id,
    }.to_json
  end

  mapping do
    indexes :id, :type => 'integer', :index => 'not_analyzed'
    indexes :name, :boost =>  100, analyzer: "snowball"
    indexes :nick_name, :boost =>  50, analyzer: "snowball"
    indexes :location, :type  => 'geo_point'
    indexes :city_id, :type =>  'integer'
  end

end