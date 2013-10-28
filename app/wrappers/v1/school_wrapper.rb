# -*- encoding : utf-8 -*-

module V1
  class SchoolWrapper < BaseWrapper

    class << self

      def schools_info(schools)
        ret = { content: {} }
        if has_size?(schools)
          ret[:content][:schools] = []
          schools.each do |school|
            ret[:content][:schools] << detail(school)
          end
        end
        ret
      end

      def detail(school)
        {
          id: school.id,
          name: school.real_name
        }
      end

    end
  end
end