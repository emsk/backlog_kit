require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'backlog_kit'
require 'webmock/rspec'
require 'vcr'

WebMock.disable_net_connect!(allow: 'coveralls.io')

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    stub_const('ENV', ENV.to_hash.merge('BACKLOG_SECOND_LEVEL_DOMAIN' => 'backlog'))
    stub_const('ENV', ENV.to_hash.merge('BACKLOG_TOP_LEVEL_DOMAIN' => 'jp'))
  end
end

VCR.configure do |c|
  c.default_cassette_options = {
    serialize_with: :json,
    preserve_exact_body_bytes: true
  }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<BACKLOG_SPACE_ID>.') { "#{ENV['BACKLOG_SPACE_ID']}." }
  c.filter_sensitive_data('<BACKLOG_API_KEY>') { ENV['BACKLOG_API_KEY'] }
  c.filter_sensitive_data('<BACKLOG_OAUTH_CLIENT_ID>') { ENV['BACKLOG_OAUTH_CLIENT_ID'] }
  c.filter_sensitive_data('<BACKLOG_OAUTH_CLIENT_SECRET>') { ENV['BACKLOG_OAUTH_CLIENT_SECRET'] }
  c.filter_sensitive_data('<BACKLOG_OAUTH_REFRESH_TOKEN>') { ENV['BACKLOG_OAUTH_REFRESH_TOKEN'] }
  c.filter_sensitive_data('<BACKLOG_KIT_USER_AGENT>') { BacklogKit::Client::USER_AGENT }
end
