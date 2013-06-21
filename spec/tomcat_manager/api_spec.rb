require 'spec_helper'

describe Tomcat::Manager::Api do
  subject { Tomcat::Manager::Api }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  it "returns an array of supported versions" do
    Tomcat::Manager::Api.supported_versions.should be_instance_of(Array)
  end
end
