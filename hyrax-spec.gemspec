# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyrax/spec/version'

Gem::Specification.new do |spec|
  spec.authors       = ['Tom Johnson']
  spec.email         = ['tom@curationexperts.com']
  spec.description   = 'Shared tests, matchers, and smoke tests for the Hyrax Samvera engine.'
  spec.summary       = <<-EOF
  These are some tests and matchers for Hyrax.
EOF

  spec.homepage      = 'http://github.com/curationexperts/hyrax-spec'

  spec.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = 'hyrax-spec'
  spec.require_paths = ["lib"]
  spec.version       = Hyrax::Spec::VERSION
  spec.license       = 'Apache-2.0'

  spec.add_dependency 'rspec', '~> 3.6'

  spec.add_development_dependency 'bixby',       '~> 0.3'
  spec.add_development_dependency 'engine_cart', '~> 1.0'
  spec.add_development_dependency 'hyrax',       '>= 2.0'
  spec.add_development_dependency 'rake'
end
