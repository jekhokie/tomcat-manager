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

    describe "deployed_applications" do
      let(:api)              { FactoryGirl.build :api, :version => "7" }
      let(:application_list) { File.open(File.dirname(__FILE__) + "/../../fixtures/application_list.txt", "r").read }

      it "returns a hash of applications" do
        api.deployed_applications(application_list).should ==
          { "/"                     => { :status => "running", :sessions => 0, :name => "ROOT"                 },
            "/manager"              => { :status => "running", :sessions => 2, :name => "manager"              },
            "/docs"                 => { :status => "running", :sessions => 0, :name => "docs"                 },
            "/test-app-1.0.0"       => { :status => "running", :sessions => 2, :name => "test-app-1.0.0"       },
            "/test-app-2.0.1"       => { :status => "running", :sessions => 0, :name => "test-app-2.0.1"       },
            "/other-test-app-1.0.1" => { :status => "stopped", :sessions => 0, :name => "other-test-app-1.0.1" },
            "/examples"             => { :status => "running", :sessions => 1, :name => "examples"             },
            "/host-manager"         => { :status => "running", :sessions => 0, :name => "host-manager"         } }
      end
    end

    describe "application_deployed?" do
      let(:api)              { FactoryGirl.build :api, :version => "7" }
      let(:application_list) { File.open(File.dirname(__FILE__) + "/../../fixtures/application_list.txt", "r").read }

      it "returns true for a deployed application" do
        api.application_deployed?("test-app", "1.0.0", application_list).should == true
      end

      it "returns false for a non-deployed application" do
        api.application_deployed?("bogus", "2.0.0", application_list).should == false
      end
    end

    describe "application_running?" do
      let(:api)              { FactoryGirl.build :api, :version => "7" }
      let(:application_list) { File.open(File.dirname(__FILE__) + "/../../fixtures/application_list.txt", "r").read }

      it "returns true for a running application" do
        api.application_running?("test-app", "1.0.0", application_list).should == true
      end

      it "returns false for a stopped application" do
        api.application_running?("other-test-app", "1.0.1", application_list).should == false
      end
    end
  end
end
