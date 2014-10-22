# -*- encoding : utf-8 -*-

module V1
  class SchoolService

    class << self

      def list(page)
        schools = School.paginate(page)
        V1::SchoolWrapper.schools_info(schools)
      end

      def get_school(id)
        school = School.find_by_id(id)
        V1::SchoolWrapper.detail(school) if school
      end

    end
  end
end