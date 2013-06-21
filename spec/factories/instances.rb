FactoryGirl.define do
  factory :instance, :class => "Tomcat::Manager::Instance" do
    host           "localhost"
    port           8280
    admin_username "cool_admin"
    admin_password "sup3rC00lp4$$"
    api_version    "7"

    initialize_with {
      new(:host => host, :port => port, :admin_username => admin_username, :admin_password => admin_password, :opts => { :api_version => api_version })
    }
  end
end
