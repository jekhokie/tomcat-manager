require 'spec_helper'

describe Tomcat::Manager::Api do
  subject { Tomcat::Manager::Api }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end
end
