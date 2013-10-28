# -*- coding: utf-8 -*-

module V1
  class BaseApi < Grape::API

    def self.inherited(subclass)
      super

      subclass.instance_eval do
        helpers ApiHelpers
        version 'v1'
      end
    end

  end
end