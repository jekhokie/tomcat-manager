require_relative "tomcat-manager/version"
require_relative "tomcat-manager/instance"
require_relative "tomcat-manager/api"

module Tomcat
  module Manager
    class << self
      # Public: Initializes a new TomcatManager::Instance.
      #
      # host           - Host on which the Tomcat server is running.
      # port           - Optional port on which the Tomcat Manager is listening (default = 8080).
      # admin_user     - Optional username for the administrative user for the Tomcat Manager application (default = admin).
      # admin_password - Optional password for the administrative user for the Tomcat Manager application (default = admin).
      # options        - Optional hash used to configure this TomcatManager (default = nil).
      #                    :api_version - Version of the TomcatManager API to use (drives the schema)
      #
      # Examples
      #
      #   Tomcat::Manager.new :host           => 'http://myHost.internal.com',
      #                       :port           => 9090,
      #                       :admin_password => 'my$ecr3tP4SS'
      #
      # Returns a TomcatManager::Instance.
      #
      def new(args = nil)
        Tomcat::Manager::Instance.new args
      end
    end
  end
end
