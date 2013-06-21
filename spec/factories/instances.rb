FactoryGirl.define do
  factory :instance, :class => "Tomcat::Manager::Instance" do
    host             "my.host"
    port             8280
    manager_username "cool_admin"
    manager_password "sup3rC00lp4$$"
    api_version      "7"

    initialize_with {
      new(:host => host, :port => port, :manager_username => manager_username, :manager_password => manager_password, :opts => { :api_version => api_version })
    }
  end
end
