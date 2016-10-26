module BacklogKit
  class Client
    # Methods for OAuth 2.0 authorization
    #
    # @see http://developer.nulab-inc.com/docs/backlog/auth
    module Authorization
      # Create a new access token
      #
      # @param oauth_code [String] Authorization code that you get from the authorization endpoint
      # @return [BacklogKit::Response] The token information
      def create_token(oauth_code)
        params = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'authorization_code',
          code: oauth_code
        }
        params[:redirect_uri] = redirect_uri if redirect_uri
        request(:post, 'oauth2/token', params, true)
      end

      # Refresh an access token
      #
      # @return [BacklogKit::Response] The token information
      def update_token
        params = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'refresh_token',
          refresh_token: refresh_token
        }
        request(:post, 'oauth2/token', params, true)
      end
    end
  end
end
