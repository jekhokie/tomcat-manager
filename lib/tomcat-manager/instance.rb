module Tomcat
  module Manager
    DEFAULT_PORT           = 9090
    DEFAULT_ADMIN_USERNAME = "admin"
    DEFAULT_ADMIN_PASSWORD = "admin"

    class Instance
      attr_accessor :host, :port, :admin_username, :admin_password

      def initialize(args)
        # initialize default attributes
        self.port           = Tomcat::Manager::DEFAULT_PORT
        self.admin_username = Tomcat::Manager::DEFAULT_ADMIN_USERNAME
        self.admin_password = Tomcat::Manager::DEFAULT_ADMIN_PASSWORD

        # assign overrideable attributes
        self.host           = args[:host].to_s           unless args[:host].nil?
        self.port           = args[:port].to_i           unless args[:port].nil?
        self.admin_username = args[:admin_username].to_s unless args[:admin_username].nil?
        self.admin_password = args[:admin_password].to_s unless args[:admin_password].nil?

        self.valid?
      end

      def valid?
        raise "Missing :host Parameter"                  if self.host.nil?      or self.host.empty?
        raise "Missing or Non-Numeric :port Parameter"   if self.port.nil?      or self.port      == 0 or
                                                                                   self.port.to_s == ""
        raise ":port not within range 1 < :port < 65535" if self.port > 65535   or self.port < 1
        raise ":admin_username cannot be blank"          if admin_username.nil? or admin_username.empty?
        raise ":admin_password cannot be blank"          if admin_password.nil? or admin_password.empty?

        true
      end
    end
  end
end
