# -*- coding: utf-8 -*-

module V1
  class SchoolApi < BaseApi
    resource :schools do

      desc "获取学校列表接口"
      params do
        optional :page, :type => Integer, :desc => "Page number"
      end

      get do
        authentication
        content = V1::SchoolService.list(params[:page])
        render_json content
      end

      desc "获取学校详情接口"
      params do
        optional :id, :type => Integer, :desc => "School ID"
      end

      get '/:id' do
        authentication
        content = V1::SchoolService.get_school(params[:id])
        render_or_cache(content: content)
      end

    end
  end
end
