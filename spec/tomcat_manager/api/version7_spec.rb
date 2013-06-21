require 'spec_helper'

describe Tomcat::Manager::Api::Version7 do
  context "url response methods" do
    describe "connect_path" do
      it "returns the connect_path for Tomcat Manager" do
        FactoryGirl.build(:api, :version => "7").connect_path.should be_instance_of(String)
      end
    end
  end

  context "processing methods" do
    describe "connect_response_valid?" do
      let(:api) { FactoryGirl.build :api, :version => "7" }

      it "returns true for a valid response HTTP code" do
        api.connect_response_valid?("200").should == true
      end

      it "returns false for an non-OK response HTTP code" do
        api.connect_response_valid?("abc").should == false
      end
    end
  end
end
