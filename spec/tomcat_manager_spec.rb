require 'spec_helper'

describe Tomcat::Manager do
  subject { Tomcat::Manager }

  it "can create a new instance" do
    subject.should respond_to(:new)
  end

  describe "new" do
    it "returns a new Server instance" do
      Tomcat::Manager.new(:host => "http://www.google.com/").should be_instance_of(Tomcat::Manager::Instance)
    end
  end
end
