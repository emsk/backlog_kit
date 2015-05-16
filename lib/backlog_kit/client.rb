require 'backlog_kit/error'
require 'backlog_kit/response'
require 'backlog_kit/version'
require 'backlog_kit/client/authorization'
require 'backlog_kit/client/git'
require 'backlog_kit/client/group'
require 'backlog_kit/client/issue'
require 'backlog_kit/client/notification'
require 'backlog_kit/client/priority'
require 'backlog_kit/client/project'
require 'backlog_kit/client/resolution'
require 'backlog_kit/client/space'
require 'backlog_kit/client/star'
require 'backlog_kit/client/status'
require 'backlog_kit/client/user'
require 'backlog_kit/client/wiki'
require 'backlog_kit/response/file_parser'
require 'backlog_kit/response/raise_error'
require 'backlog_kit/hash_extensions'

module BacklogKit
  class Client
    include BacklogKit::Client::Authorization
    include BacklogKit::Client::Git
    include BacklogKit::Client::Group
    include BacklogKit::Client::Issue
    include BacklogKit::Client::Notification
    include BacklogKit::Client::Priority
    include BacklogKit::Client::Project
    include BacklogKit::Client::Resolution
    include BacklogKit::Client::Space
    include BacklogKit::Client::Star
    include BacklogKit::Client::Status
    include BacklogKit::Client::User
    include BacklogKit::Client::Wiki

    USER_AGENT = "BacklogKit Ruby Gem #{BacklogKit::VERSION}".freeze

    attr_accessor(
      :space_id,
      :api_key,
      :client_id,
      :client_secret,
      :refresh_token,
      :redirect_uri,
      :state,
      :access_token
    )

    def initialize(options = {})
      @space_id      = ENV['BACKLOG_SPACE_ID']
      @api_key       = ENV['BACKLOG_API_KEY']
      @client_id     = ENV['BACKLOG_OAUTH_CLIENT_ID']
      @client_secret = ENV['BACKLOG_OAUTH_CLIENT_SECRET']
      @refresh_token = ENV['BACKLOG_OAUTH_REFRESH_TOKEN']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    def authorization_url
      url = "#{host}/OAuth2AccessRequest.action?response_type=code&client_id=#{@client_id}"
      url += "&redirect_uri=#{URI.escape(@redirect_uri)}" if @redirect_uri
      url += "&state=#{@state}" if @state
      url
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

    def request(method, path, params = {}, raw_params = false)
      params.camelize_keys! unless raw_params
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
      headers = { 'User-Agent' => USER_AGENT }
      headers.merge!('Authorization' => "Bearer #{@access_token}") if oauth_request?
      headers
    end

    def oauth_request?
      !@api_key && @access_token
    end

    def request_path(path)
      path = "/api/v2/#{URI.escape(path)}"
      path += "?apiKey=#{URI.escape(@api_key.to_s)}" if @api_key
      path
    end
  end
end
