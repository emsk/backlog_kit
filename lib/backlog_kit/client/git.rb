module BacklogKit
  class Client
    # Methods for the Git API
    module Git

      # Get list of git repositories
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of git repositories
      def get_git_repositories(project_id_or_key)
        get('git/repositories', project_id_or_key: project_id_or_key)
      end
    end
  end
end
