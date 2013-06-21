require 'spec_helper'

describe Tomcat::Manager::Api do
  subject { Tomcat::Manager::Api }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  it "returns an array of supported versions" do
    Tomcat::Manager::Api.supported_versions.should be_instance_of(Array)
  end

  describe "new" do
    it "returns a new Api instance" do
      Tomcat::Manager::Api.new("7").should be_instance_of(Tomcat::Manager::Api::Version7)
    end

    it "raises an error for an unknown version" do
      expect{ Tomcat::Manager::Api.new("X") }.to raise_error
    end
  end
end
