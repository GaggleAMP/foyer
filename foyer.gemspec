# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foyer/version'

Gem::Specification.new do |spec|
  spec.name          = 'foyer'
  spec.version       = Foyer::VERSION
  spec.authors       = ['GaggleAMP']
  spec.email         = ['info@gaggleamp.com']
  spec.summary       = 'Authentication layer for OmniAuth'
  spec.description   = 'Authentication layer for OmniAuth'
  spec.homepage      = 'https://github.com/GaggleAMP/foyer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)\/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 4.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails', '~> 3.5'
end
