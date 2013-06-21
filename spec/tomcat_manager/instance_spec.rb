require 'spec_helper'

describe Tomcat::Manager::Instance do
  subject { Tomcat::Manager::Instance }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "attributes" do
    let(:manager_instance) { FactoryGirl.build :instance }

    it { manager_instance.should respond_to(:host)           }
    it { manager_instance.should respond_to(:port)           }
    it { manager_instance.should respond_to(:admin_username) }
    it { manager_instance.should respond_to(:admin_password) }
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

    # admin_username
    it "raises error for a missing admin_username" do
      expect{ FactoryGirl.build(:instance, :admin_username => "") }.to raise_error
    end

    # admin_password
    it "raises error for a missing admin_password" do
      expect{ FactoryGirl.build(:instance, :admin_password => "") }.to raise_error
    end
  end
end
