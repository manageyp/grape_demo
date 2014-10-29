# -*- encoding : utf-8 -*-

require 'spec_helper'

module V1
  describe SchoolApi do

    before(:each) do
      @school = create(:school)
      RedisToken.stub(:fetch_token) { "token" }
      RedisToken.stub(:create_token) { "token" }
      RedisToken.stub(:verify_token) { "token" }
    end

    describe "GET api /v1/schools" do
      it "should get schools list" do
        get "/v1/schools"
        response.status.should == 200
        resp_data = JSON.parse(response.body)
        resp_data["status"].should == "0000"
        resp_data["content"]["schools"].size.should > 0
        resp_data["content"]["schools"].first["name"].should == @school.real_name
      end
    end

  end
end