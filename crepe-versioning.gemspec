# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'crepe/versioning/version'

Gem::Specification.new do |s|
  s.name          = 'crepe-versioning'
  s.version       = Crepe::Versioning::VERSION
  s.authors       = ['David Celis', 'Stephen Celis', 'Evan Owen']
  s.email         = %w[
    me@davidcel.is
    stephen@stephencelis.com
    kainosnoema@gmail.com
  ]

  s.summary       = 'Version your Crepe APIs.'
  s.description   = <<-DESCRIPTION.gsub(/^\s{4}/, '')
    Add support for versioning your Crepe APIs in the URL path, a query
    parameter, or an Accept header with a vendor string.
  DESCRIPTION

  s.has_rdoc      = false

  s.homepage      = 'https://github.com/crepe/crepe-versioning'
  s.license       = 'MIT'

  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'activesupport', '>= 4.0.0'
  s.add_dependency 'rack',          '~> 1.5.x'
  s.add_dependency 'rack-mount',    '~> 0.8.x'

  s.add_development_dependency 'cane',       '~> 2.6.x'
  s.add_development_dependency 'rake',       '~> 10.3.x'
  s.add_development_dependency 'rspec',      '~> 3.0.x'
  s.add_development_dependency 'rack-test',  '~> 0.6.x'
  s.add_development_dependency 'yard',       '~> 0.8.x'
end
