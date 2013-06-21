require 'spec_helper'

describe Tomcat::Manager::Api::Version7 do
  context "url response methods" do
    describe "connect_path" do
      it "returns the connect_path for Tomcat Manager" do
        FactoryGirl.build(:api, :version => "7").connect_path.should be_instance_of(String)
      end
    end
  end
end
