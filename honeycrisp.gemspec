# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'honeycrisp/version'

Gem::Specification.new do |spec|
  spec.name          = 'honeycrisp'
  spec.version       = Honeycrisp::VERSION
  spec.authors       = ['Justin Rhinesmith']
  spec.email         = ['jerhinesmith@gmail.com']
  spec.summary       = "A simple library for communicating with Apple's iTunes receipt validation server."
  spec.description   = "A simple library for communicating with Apple's iTunes receipt validation server."
  spec.homepage      = 'http://github.com/jerhinesmith/honeycrisp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'honeycrisp', '--main', 'README.md']

  spec.add_dependency 'faraday', ['>= 0.8', '< 0.10']
  spec.add_dependency 'multi_json', '>= 1.3.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'honeycrisp', '--main', 'README.md']
end
