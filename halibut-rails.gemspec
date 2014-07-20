# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'halibut/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'halibut-rails'
  spec.version       = Halibut::Rails::VERSION
  spec.authors       = ['Toru KAWAMURA']
  spec.email         = ['tkawa@4bit.net']
  spec.summary       = %q{Rails Template Handler for Halibut Builder}
  spec.description   = %q{Rails Template Handler for Halibut Builder}
  spec.homepage      = 'https://github.com/tkawa/halibut-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'halibut'
  spec.add_dependency 'rails'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
