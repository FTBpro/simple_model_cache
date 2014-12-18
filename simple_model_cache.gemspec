# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_model_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_model_cache"
  spec.version       = SimpleModelCache::VERSION
  spec.authors       = ["90min.com"]
  spec.email         = ["alexeymn@gmail.com"]
  spec.summary       = "Simple gem for caching active record models in memory."
  spec.description   = "Simple gem for caching active record models in memory."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
