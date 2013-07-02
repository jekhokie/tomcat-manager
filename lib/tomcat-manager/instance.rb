require 'net/http'

module Tomcat
  module Manager
    DEFAULT_PORT             = 8080
    DEFAULT_MANAGER_USERNAME = "admin"
    DEFAULT_MANAGER_PASSWORD = "admin"
    DEFAULT_API_VERSION      = "7"

    class Instance
      attr_accessor :host, :port, :manager_username, :manager_password
      attr_reader   :api_version, :api

      def initialize(args)
        # initialize default attributes
        self.port             = Tomcat::Manager::DEFAULT_PORT
        self.manager_username = Tomcat::Manager::DEFAULT_MANAGER_USERNAME
        self.manager_password = Tomcat::Manager::DEFAULT_MANAGER_PASSWORD
        @api_version          = DEFAULT_API_VERSION

        # assign overrideable attributes
        self.host             = args[:host].to_s           unless args[:host].nil?
        self.port             = args[:port].to_i           unless args[:port].nil?
        self.manager_username = args[:manager_username].to_s unless args[:manager_username].nil?
        self.manager_password = args[:manager_password].to_s unless args[:manager_password].nil?

        unless (extra_opts = args[:opts]).nil?
          @api_version = extra_opts[:api_version].to_s if extra_opts[:api_version]
        end

        begin
          # build a new API object
          @api = Tomcat::Manager::Api.new(@api_version)
        rescue Exception => e
          raise e.message
        end

        self.valid?
      end

      def valid?
        raise "Missing :host Parameter"                  if self.host.nil?        or self.host.empty?
        raise "Missing or Non-Numeric :port Parameter"   if self.port.nil?        or self.port      == 0 or
                                                                                     self.port.to_s == ""
        raise ":port not within range 1 < :port < 65535" if self.port > 65535     or self.port < 1
        raise ":manager_username cannot be blank"        if manager_username.nil? or manager_username.empty?
        raise ":manager_password cannot be blank"        if manager_password.nil? or manager_password.empty?

        true
      end

      def api_version=(api_version)
        begin
          # build a new API object
          @api         = Tomcat::Manager::Api.new(api_version)
          @api_version = api_version
        rescue Exception => e
          raise e.message
        end
      end

      def can_connect?
        begin
          response       = get_application_list
          valid_response = @api.connect_response_valid?(response.code)
        rescue Exception => e
          raise e.message
        end

        return valid_response
      end

      def application_list
        begin
          raise "Could not connect to server" unless can_connect?

          response         = get_application_list
          application_hash = @api.deployed_applications(response.body)
        rescue Exception => e
          raise e.message
        end

        return application_hash
      end

      def is_application_deployed?(application_name, version)
        begin
          raise "Could not connect to server" unless can_connect?

          response           = get_application_list
          application_status = @api.application_deployed?(application_name, version, response.body)
        rescue Exception => e
          raise e.message
        end

        return application_status
      end

      private

      def get_application_list
        begin
          response = Net::HTTP.start(self.host, self.port) do |http|
            request = Net::HTTP::Get.new(@api.connect_path)
            request.basic_auth(self.manager_username, self.manager_password)
            http.request request
          end
        rescue Exception => e
          raise e.message
        end

        response
      end
    end
  end
end
