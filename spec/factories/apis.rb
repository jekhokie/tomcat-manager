FactoryGirl.define do
  factory :api, :class => "Tomcat::Manager::Api" do
    version "7"

    initialize_with { new(version) }
  end
end
