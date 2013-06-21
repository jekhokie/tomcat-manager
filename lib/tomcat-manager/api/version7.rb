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
      end
    end
  end
end
