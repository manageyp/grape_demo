# -*- coding: utf-8 -*-

module V1
  class SchoolApi < BaseApi
    resource :schools do

      desc "获取学校列表接口"
      params do
        optional :page, :type => String, :desc => "School list page number"
      end

      get do
        authentication
        content = V1::SchoolService.list(params[:page])
        render_json content
      end

    end
  end
end
