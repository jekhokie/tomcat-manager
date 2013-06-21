# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tomcat-manager/version'

Gem::Specification.new do |spec|
  spec.name          = "tomcat-manager"
  spec.version       = Tomcat::Manager::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = [ "Justin Karimi" ]
  spec.email         = [ "jekhokie@gmail.com" ]
  spec.description   = %q{API to manage an Apache Tomcat Web Server instance}
  spec.summary       = %q{Provides an interface to the Tomcat Manager in order to manage an Apache Tomcat Web Server.}
  spec.homepage      = "https://github.com/jekhokie/tomcat-manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = [ "lib" ]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
