require 'backlog_kit/error'
require 'backlog_kit/response'
require 'backlog_kit/version'
require 'backlog_kit/client/git'
require 'backlog_kit/client/group'
require 'backlog_kit/client/priority'
require 'backlog_kit/client/resolution'
require 'backlog_kit/client/status'
require 'backlog_kit/response/file_parser'
require 'backlog_kit/response/raise_error'
require 'backlog_kit/hash_extensions'

module BacklogKit
  class Client
    include BacklogKit::Client::Git
    include BacklogKit::Client::Group
    include BacklogKit::Client::Priority
    include BacklogKit::Client::Resolution
    include BacklogKit::Client::Status

    USER_AGENT = "BacklogKit Ruby Gem #{BacklogKit::VERSION}".freeze

    attr_accessor(:space_id, :api_key)

    def initialize(options = {})
      @space_id = ENV['BACKLOG_SPACE_ID']
      @api_key  = ENV['BACKLOG_API_KEY']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def patch(path, params = {})
      request(:patch, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    private

    def request(method, path, params = {})
      params.camelize_keys!
      faraday_response = connection.send(method, request_path(path), params)
      BacklogKit::Response.new(faraday_response)
    rescue Faraday::ConnectionFailed => e
      raise BacklogKit::Error, "#{BacklogKit::ConnectionError.name.demodulize} - #{e.message}"
    end

    def connection
      Faraday.new(url: host, headers: request_headers) do |faraday|
        faraday.request(:multipart)
        faraday.request(:url_encoded)
        faraday.response(:json, content_type: /application\/json/)
        faraday.response(:file_parser)
        faraday.response(:error)
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def host
      "https://#{space_id}.backlog.jp"
    end

    def request_headers
      { 'User-Agent' => USER_AGENT }
    end

    def request_path(path)
      "/api/v2/#{URI.escape(path)}?apiKey=#{URI.escape(@api_key.to_s)}"
    end
  end
end
