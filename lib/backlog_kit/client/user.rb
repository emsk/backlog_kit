module BacklogKit
  class Client

    # Methods for the User API
    module User

      # Get list of users
      #
      # @return [BacklogKit::Response] List of users
      def get_users
        get('users')
      end

      # Get a user
      #
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def get_user(user_id)
        get("users/#{user_id}")
      end

      # Create a new user
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The user information
      def create_user(params = {})
        post('users', params)
      end

      # Update a user
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The user information
      def update_user(user_id, params = {})
        patch("users/#{user_id}", params)
      end

      # Delete a user
      #
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def delete_user(user_id)
        delete("users/#{user_id}")
      end

      # Get a authentication user
      #
      # @return [BacklogKit::Response] The user information
      def get_myself
        get('users/myself')
      end

      # Download a user icon image
      #
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] Binary image data
      def download_user_icon(user_id)
        get("users/#{user_id}/icon")
      end

      # Get list of user activities
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of user's recent updates
      def get_user_activities(user_id, params = {})
        get("users/#{user_id}/activities", params)
      end

      # Get list of user stars
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of stars
      def get_user_stars(user_id, params = {})
        get("users/#{user_id}/stars", params)
      end

      # Get number of user stars
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] Number of stars
      def get_user_star_count(user_id, params = {})
        get("users/#{user_id}/stars/count", params)
      end

      # Get list of recently viewed issues
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of recently viewed issues
      def get_recently_viewed_issues(params = {})
        get('users/myself/recentlyViewedIssues', params)
      end

      # Get list of recently viewed projects
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of recently viewed projects
      def get_recently_viewed_projects(params = {})
        get('users/myself/recentlyViewedProjects', params)
      end

      # Get list of recently viewed wiki pages
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of recently viewed pages
      def get_recently_viewed_wikis(params = {})
        get('users/myself/recentlyViewedWikis', params)
      end
    end
  end
end
