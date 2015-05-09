lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backlog_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'backlog_kit'
  spec.version       = BacklogKit::VERSION
  spec.authors       = ['emsk']
  spec.email         = ['emsk1987@gmail.com']

  spec.summary       = %q{Wrapper for the Backlog API v2.}
  spec.description   = %q{Client library for the Nulab's Backlog API version 2 written in Ruby.}
  spec.homepage      = 'https://github.com/emsk/backlog_kit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 4.2.1'
  spec.add_runtime_dependency 'faraday', '~> 0.9.1'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9.1'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.10.0'
  spec.add_development_dependency 'webmock', '~> 1.21.0'
  spec.add_development_dependency 'multi_json', '~> 1.11.0'
  spec.add_development_dependency 'vcr', '~> 2.9.3'
  spec.add_development_dependency 'coveralls', '~> 0.8.1'
end
