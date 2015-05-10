module BacklogKit
  class Client
    module User
      def get_users
        get('users')
      end

      def get_user(user_id)
        get("users/#{user_id}")
      end

      def create_user(params = {})
        post('users', params)
      end

      def update_user(user_id, params = {})
        patch("users/#{user_id}", params)
      end

      def delete_user(user_id)
        delete("users/#{user_id}")
      end

      def get_myself
        get('users/myself')
      end

      def download_user_icon(user_id)
        get("users/#{user_id}/icon")
      end

      def get_user_activities(user_id, params = {})
        get("users/#{user_id}/activities", params)
      end

      def get_user_stars(user_id, params = {})
        get("users/#{user_id}/stars", params)
      end

      def get_user_star_count(user_id, params = {})
        get("users/#{user_id}/stars/count", params)
      end

      def get_recently_viewed_issues(params = {})
        get('users/myself/recentlyViewedIssues', params)
      end

      def get_recently_viewed_projects(params = {})
        get('users/myself/recentlyViewedProjects', params)
      end

      def get_recently_viewed_wikis(params = {})
        get('users/myself/recentlyViewedWikis', params)
      end
    end
  end
end
