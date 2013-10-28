# -*- encoding : utf-8 -*-

module V1
  class SchoolService

    class << self

      def list(page)
        schools = School.paginate(page)
        V1::SchoolWrapper.schools_info(schools)
      end

    end
  end
end