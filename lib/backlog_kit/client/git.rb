module BacklogKit
  class Client
    module Git
      def get_git_repositories(project_id_or_key)
        get('git/repositories', project_id_or_key: project_id_or_key)
      end
    end
  end
end
