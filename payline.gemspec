# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payline/version'

Gem::Specification.new do |spec|
  spec.name          = "payline"
  spec.version       = Payline::VERSION
  spec.authors       = ["David Rubin"]
  spec.email         = ["david@fireid.com"]
  spec.summary       = %q{Wrapper around Payline http post api}
  spec.description   = %q{Wrapper around Payline http post api}
  spec.homepage      = "https://github.com/fireworksinnovation/payline"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.9.0'
end
