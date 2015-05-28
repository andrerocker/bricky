# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bricky/version'

Gem::Specification.new do |spec|
  spec.name          = 'bricky'
  spec.version       = Bricky::VERSION
  spec.authors       = ['andrerocker']
  spec.email         = ['andre.souza@gmail.com']
  spec.summary       = %q{a smart way to build software packages}
  spec.description   = %q{a smart way to build software packages}
  spec.homepage      = 'http://github.com/andrerocker/bricky'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{bin,lib,etc}/**/*')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'thor', '> 0.14'
  spec.add_dependency 'colorize', '~> 0.7.7'
end
