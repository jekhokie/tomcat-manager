module Tomcat
  module Manager
    module Api
      class Version7
        ###########################
        # URL Response Methods
        ###########################

        def connect_path
          "/manager/text/list"
        end

        ###########################
        # Processing Methods
        ###########################

        def connect_response_valid?(response_code)
          response_code == "200"
        end

        def deployed_applications(response)
          application_list = Hash.new

          response.split("\n")[1..-1].each do |app_info|
            app_components = app_info.split(':')
            (application_list[(app_components[3] == "ROOT" ? "/" : app_components[0])] = Hash.new).tap do |application_hash|
              application_hash[:status]   = app_components[1]
              application_hash[:sessions] = app_components[2].to_i
              application_hash[:name]     = app_components[3]
            end
          end

          application_list
        end

        def application_deployed?(application_name, version, response)
          ! deployed_applications(response)["/#{application_name}-#{version}"].nil?
        end
      end
    end
  end
end
