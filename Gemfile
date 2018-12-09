source 'https://rubygems.org'

gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.2')
  gem 'activesupport', '< 5.0.0'
end

if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create('2.1.0') && Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.0')
  gem 'rubocop', '< 0.58.0'
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.1.0')
  gem 'public_suffix', '< 3.0.0'
  gem 'rubocop', '< 0.51.0'
end
