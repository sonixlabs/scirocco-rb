# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scirocco/version'

Gem::Specification.new do |spec|
  spec.name          = "scirocco-rb"
  spec.version       = Scirocco::VERSION
  spec.authors       = ["k-yamada"]
  spec.email         = ["kyamada@sonix.asia"]

  spec.summary       = %q{Ruby wrapper for SciroccoCloud API}
  spec.description   = %q{The official Ruby client for the SciroccoCloud API.}
  spec.homepage      = "https://github.com/sonixlabs/scirocco-rb.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  #end

  spec.add_development_dependency "bundler", "~> 1.9"
  #spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'thor'
end
