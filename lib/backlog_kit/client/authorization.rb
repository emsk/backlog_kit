module BacklogKit
  class Client
    module Authorization
      def create_token(oauth_code)
        params = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'authorization_code',
          code: oauth_code
        }
        params.merge!(redirect_uri: redirect_uri) if redirect_uri
        request(:post, 'oauth2/token', params, true)
      end

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
