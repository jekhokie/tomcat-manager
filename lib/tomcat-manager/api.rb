Dir[File.expand_path(File.dirname(__FILE__) + '/api/*.rb')].each { |file| require file }

module Tomcat
  module Manager
    module Api
      class << self
        # Public: Initializes a new Tomcat::Manager::Api::Version.
        #
        # version - Version of the API to instantiate.
        #
        # Examples
        #
        #   Tomcat::Manager::Api::Version.new :api_version => '7'
        #
        # Returns a Tomcat::Manager::Api::Version.
        #
        def new(version)
          if self.supported_versions.include? version
            new_api = self.const_get("Version#{version}").new
          else
            raise "Invalid API version - acceptable versions are: #{self.supported_versions}"
          end

          new_api
        end

        def supported_versions
          [ '7' ]
        end
      end
    end
  end
end
