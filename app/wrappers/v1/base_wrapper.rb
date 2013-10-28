# -*- encoding : utf-8 -*-

module V1
  class BaseWrapper

    class << self

      def has_value?(value)
        value && !value.blank?
      end

      def has_size?(value)
        value && value.size > 0
      end

    end

  end
end