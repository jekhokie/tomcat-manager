require 'spec_helper'

describe Tomcat::Manager::Instance do
  subject { Tomcat::Manager::Instance }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "attributes" do
    let(:manager_instance) { FactoryGirl.build :instance }

    it { manager_instance.should respond_to(:host)             }
    it { manager_instance.should respond_to(:port)             }
    it { manager_instance.should respond_to(:manager_username) }
    it { manager_instance.should respond_to(:manager_password) }
  end

  describe "valid?" do
    it "returns true for valid attributes" do
      expect { FactoryGirl.build(:instance) }.to_not raise_error
    end

    # host
    it "raises error for a missing host" do
      expect{ FactoryGirl.build(:instance, :host => "") }.to raise_error
    end

    # port
    it "raises error for a missing port" do
      expect{ FactoryGirl.build(:instance, :port => "") }.to raise_error
    end

    it "returns true for a port of type String" do
      expect{ FactoryGirl.build(:instance, :port => "8080") }.to_not raise_error
    end

    it "raises error for an invalid port of type String" do
      expect{ FactoryGirl.build(:instance, :port => "abc") }.to raise_error
    end

    it "raises error for a port outside of acceptable range 1-65535" do
      expect{ FactoryGirl.build(:instance, :port => 70000) }.to raise_error
    end

    # manager_username
    it "raises error for a missing manager_username" do
      expect{ FactoryGirl.build(:instance, :manager_username => "") }.to raise_error
    end

    # manager_password
    it "raises error for a missing manager_password" do
      expect{ FactoryGirl.build(:instance, :manager_password => "") }.to raise_error
    end

    # api_version
    it "returns true for a valid api_version" do
      expect{ FactoryGirl.build(:instance, :api_version => "7") }.to_not raise_error
    end

    it "raises error for an unspecified api_version" do
      expect{ FactoryGirl.build(:instance, :api_version => "") }.to raise_error
    end

    it "raises error for an unsupported api_version" do
      expect{ FactoryGirl.build(:instance, :api_version => "X") }.to raise_error
    end
  end

  describe "api_version" do
    before :each do
      @manager_instance = FactoryGirl.build :instance
    end

    it "assigns the corresponding API version when the version exists" do
      @manager_instance.api_version = "7"
      @manager_instance.api_version.should == "7"
    end

    it "raises error when the version does not exist" do
      expect{ @manager_instance.api_version=("13") }.to raise_error
    end

    it "retains the previous version when a specified version does not exist" do
      @manager_instance.stub('api_version=').and_return true

      @manager_instance.api_version = "13"
      @manager_instance.api_version.should == "7"
    end
  end

  describe "can_connect?" do
    let(:host)             { "my.host"    }
    let(:port)             { "9001"       }
    let(:manager_username) { "admin"      }
    let(:manager_password) { "s3cre7Pas$" }

    describe "for a non-reachable server" do
      let(:manager_instance) { FactoryGirl.build :instance }

      it "raises an exception" do
        expect{ manager_instance.can_connect? }.to raise_error
      end
    end

    describe "for valid connection credentials" do
      let(:manager_instance) { FactoryGirl.build :instance, :host => host,
                                                            :port => port,
                                                            :manager_username => manager_username,
                                                            :manager_password => manager_password }

      before :each do
        FakeWeb.register_uri(:get, "http://#{manager_username}:#{manager_password}@#{host}:#{port}/manager/text/list",
                                   :body => File.open(File.dirname(__FILE__) + "/../fixtures/application_list.txt", "r").read,
                                   :status => [ "200", "OK" ])
      end

      it "returns true" do
        manager_instance.can_connect?.should be_true
      end
    end

    describe "for invalid connection credentials" do
      let(:manager_instance) { FactoryGirl.build :instance, :host => host, :port => port }

      before :each do
        FakeWeb.register_uri(:get, "http://#{host}:#{port}/manager/text/list",
                                   :body => File.open(File.dirname(__FILE__) + "/../fixtures/invalid_connect.html", "r").read,
                                   :status => [ "401", "Unauthorized" ])
      end

      it "raises an exception" do
        expect{ manager_instance.can_connect? }.to raise_error
      end
    end
  end
end
