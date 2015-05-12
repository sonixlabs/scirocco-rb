# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scirocco/version'

Gem::Specification.new do |spec|
  spec.name          = "scirocco"
  spec.version       = Scirocco::VERSION
  spec.authors       = ["k-yamada"]
  spec.email         = ["customer_support@scirocco-cloud.com"]

  spec.summary       = %q{API client for SciroccoCloud}
  spec.description   = %q{Run tests using SciroccoCloud's mobile devices.}
  spec.homepage      = "https://github.com/sonixlabs/scirocco-rb.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  #end

  spec.add_dependency 'rest-client'
  spec.add_dependency 'thor'
  spec.add_development_dependency 'rspec', '~> 2.11'
  spec.add_development_dependency 'fuubar'
  spec.add_development_dependency "fakeweb", "~> 1.3"
  spec.add_development_dependency 'timecop', "~> 0.6"
  spec.add_development_dependency "bundler", "~> 1.9"
  #spec.add_development_dependency "rake", "~> 10.0"
end
