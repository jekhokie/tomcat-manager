# Tomcat::Manager [![Build Status](https://travis-ci.org/jekhokie/tomcat-manager.png)](https://travis-ci.org/jekhokie/tomcat-manager)

Provide an API to manage an Apache Tomcat Web Server via the Tomcat Manager.

## Installation

Add this line to your application's Gemfile:

    gem 'tomcat-manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tomcat-manager

## Usage

    # create a new Tomcat::Manager Instance for Tomcat
    server = Tomcat::Manager.new :host             => '192.168.1.56',
                                 :port             => 9090,
                                 :manager_username => 'cool_manager',
                                 :manager_password => 'mysu7erP4$$w0RD',
                                 :opts             => { :api_version => "7" }

    # check whether the created server instance can connect to the Tomcat Manager instance
    server.can_connect?   # true

    # obtain a hash of information for all deployed applications
    server.application_list   # sample output below:
      #  {
      #   "/"             => { :status => "running", :sessions => 0, :name => "ROOT"         },
      #   "/manager"      => { :status => "running", :sessions => 0, :name => "manager"      },
      #   "/docs"         => { :status => "running", :sessions => 0, :name => "docs"         },
      #   "/examples"     => { :status => "running", :sessions => 0, :name => "examples"     },
      #   "/host-manager" => { :status => "running", :sessions => 0, :name => "host-manager" }
      #  }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
