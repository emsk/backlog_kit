module BacklogKit
  class Client

    # Methods for the Project API
    module Project

      # Get list of projects
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of projects
      def get_projects(params = {})
        get('projects', params)
      end

      # Get a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] The project information
      def get_project(project_id_or_key)
        get("projects/#{project_id_or_key}")
      end

      # Create a new project
      #
      # @param key [String] Project key
      # @param name [String] Project name
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The project information
      def create_project(key, name, params = {})
        params.merge!(key: key, name: name)
        post('projects', params)
      end

      # Update a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The project information
      def update_project(project_id_or_key, params = {})
        patch("projects/#{project_id_or_key}", params)
      end

      # Delete a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] The project information
      def delete_project(project_id_or_key)
        delete("projects/#{project_id_or_key}")
      end

      # Download a project icon image
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] Binary image data
      def download_project_icon(project_id_or_key)
        get("projects/#{project_id_or_key}/image")
      end

      # Get list of project activities
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of recent updates in the project
      def get_project_activities(project_id_or_key, params = {})
        get("projects/#{project_id_or_key}/activities", params)
      end

      # Get list of project members
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of users
      def get_project_users(project_id_or_key)
        get("projects/#{project_id_or_key}/users")
      end

      # Add a user to a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def add_project_user(project_id_or_key, user_id)
        post("projects/#{project_id_or_key}/users", user_id: user_id)
      end

      # Remove a user from project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def remove_project_user(project_id_or_key, user_id)
        delete("projects/#{project_id_or_key}/users", user_id: user_id)
      end

      # Get list of users who has Project Administrator role
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of users
      def get_project_administrators(project_id_or_key)
        get("projects/#{project_id_or_key}/administrators")
      end

      # Add Project Administrator role to a user
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def add_project_admin_auth(project_id_or_key, user_id)
        post("projects/#{project_id_or_key}/administrators", user_id: user_id)
      end

      # Remove Project Administrator role from user
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] The user information
      def remove_project_admin_auth(project_id_or_key, user_id)
        delete("projects/#{project_id_or_key}/administrators", user_id: user_id)
      end

      # Get list of issue types
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of issue types
      def get_issue_types(project_id_or_key)
        get("projects/#{project_id_or_key}/issueTypes")
      end

      # Add an issue type to a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param name [String] Issue type name
      # @param color [String] Background color of the issue type
      # @return [BacklogKit::Response] The issue type information
      def add_issue_type(project_id_or_key, name, color)
        post("projects/#{project_id_or_key}/issueTypes", name: name, color: color)
      end

      # Update an issue type
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param type_id [Integer, String] Issue type id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The issue type information
      def update_issue_type(project_id_or_key, type_id, params = {})
        patch("projects/#{project_id_or_key}/issueTypes/#{type_id}", params)
      end

      # Remove an issue type from project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param type_id [Integer, String] Issue type id
      # @param substitute_type_id [Integer, String] Issue type id to change linked issue
      # @return [BacklogKit::Response] The issue type information
      def remove_issue_type(project_id_or_key, type_id, substitute_type_id)
        delete("projects/#{project_id_or_key}/issueTypes/#{type_id}", substitute_issue_type_id: substitute_type_id)
      end

      # Get list of categories
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of categories
      def get_categories(project_id_or_key)
        get("projects/#{project_id_or_key}/categories")
      end

      # Add a category to a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param name [String] Category name
      # @return [BacklogKit::Response] The category information
      def add_category(project_id_or_key, name)
        post("projects/#{project_id_or_key}/categories", name: name)
      end

      # Update a category
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param category_id [Integer, String] Category id
      # @param name [String] Category name
      # @return [BacklogKit::Response] The category information
      def update_category(project_id_or_key, category_id, name)
        patch("projects/#{project_id_or_key}/categories/#{category_id}", name: name)
      end

      # Remove a category from project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param category_id [Integer, String] Category id
      # @return [BacklogKit::Response] The category information
      def remove_category(project_id_or_key, category_id)
        delete("projects/#{project_id_or_key}/categories/#{category_id}")
      end

      # Get list of versions
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of versions
      def get_versions(project_id_or_key)
        get("projects/#{project_id_or_key}/versions")
      end

      # Add a version to a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param name [String] Version name
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The version information
      def add_version(project_id_or_key, name, params = {})
        params.merge!(name: name)
        post("projects/#{project_id_or_key}/versions", params)
      end

      # Update a version
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param version_id [Integer, String] Version id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The version information
      def update_version(project_id_or_key, version_id, params = {})
        patch("projects/#{project_id_or_key}/versions/#{version_id}", params)
      end

      # Remove a version from project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param version_id [Integer, String] Version id
      # @return [BacklogKit::Response] The version information
      def remove_version(project_id_or_key, version_id)
        delete("projects/#{project_id_or_key}/versions/#{version_id}")
      end

      # Get list of shared files
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param directory_path [String] Directory path
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of files
      def get_shared_files(project_id_or_key, directory_path = '', params = {})
        get("projects/#{project_id_or_key}/files/metadata/#{directory_path}", params)
      end

      # Download a shared file
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param file_id [Integer, String] Shared file id
      # @return [BacklogKit::Response] Binary data
      def download_shared_file(project_id_or_key, file_id)
        get("projects/#{project_id_or_key}/files/#{file_id}")
      end

      # Get disk usage
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] The disk usage information
      def get_project_disk_usage(project_id_or_key)
        get("projects/#{project_id_or_key}/diskUsage")
      end

      # Get list of webhooks
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of webhooks
      def get_webhooks(project_id_or_key)
        get("projects/#{project_id_or_key}/webhooks")
      end

      # Get a webhook
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param webhook_id [Integer, String] Webhook id
      # @return [BacklogKit::Response] The webhook information
      def get_webhook(project_id_or_key, webhook_id)
        get("projects/#{project_id_or_key}/webhooks/#{webhook_id}")
      end

      # Add a webhook to a project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param name [String] Webhook name
      # @param hook_url [String] Webhook URL
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The webhook information
      def add_webhook(project_id_or_key, name, hook_url, params = {})
        params.merge!(name: name, hook_url: hook_url)
        post("projects/#{project_id_or_key}/webhooks", params)
      end

      # Update a webhook
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param webhook_id [Integer, String] Webhook id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The webhook information
      def update_webhook(project_id_or_key, webhook_id, params = {})
        patch("projects/#{project_id_or_key}/webhooks/#{webhook_id}", params)
      end

      # Remove a webhook from project
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param webhook_id [Integer, String] Webhook id
      # @return [BacklogKit::Response] The webhook information
      def remove_webhook(project_id_or_key, webhook_id)
        delete("projects/#{project_id_or_key}/webhooks/#{webhook_id}")
      end

      # Get list of pull requests
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @return [BacklogKit::Response] List of pull requests
      def get_pull_requests(project_id_or_key, repository_id_or_name)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests")
      end

      # Get number of pull requests
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @return [BacklogKit::Response] Number of pull requests
      def get_pull_request_count(project_id_or_key, repository_id_or_name)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/count")
      end

      # Get a pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @return [BacklogKit::Response] The pull request information
      def get_pull_request(project_id_or_key, repository_id_or_name, pull_request_number)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}")
      end

      # Create a new pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The pull request information
      def create_pull_request(project_id_or_key, repository_id_or_name, params = {})
        post("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests", params)
      end

      # Update a pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The pull request information
      def update_pull_request(project_id_or_key, repository_id_or_name, pull_request_number, params = {})
        patch("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}", params)
      end

      # Get list of comments in pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @return [BacklogKit::Response] List of comments
      def get_pull_request_comments(project_id_or_key, repository_id_or_name, pull_request_number)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/comments")
      end

      # Get number of comments in pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @return [BacklogKit::Response] Number of comments
      def get_pull_request_comment_count(project_id_or_key, repository_id_or_name, pull_request_number)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/comments/count")
      end

      # Add a comment to a pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The comment information
      def add_pull_request_comment(project_id_or_key, repository_id_or_name, pull_request_number, params = {})
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/comments", params)
      end

      # Update a comment in pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @param comment_id [Integer, String] Comment id
      # @param content [String] Content of the comment
      # @return [BacklogKit::Response] The comment information
      def update_pull_request_comment(project_id_or_key, repository_id_or_name, pull_request_number, comment_id, content)
        patch("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/comments/#{comment_id}", content: content)
      end

      # Get list of attachment files on pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @return [BacklogKit::Response] List of files
      def get_pull_request_attachments(project_id_or_key, repository_id_or_name, pull_request_number)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/attachments")
      end

      # Download an attachment file on pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @param attachment_id [Integer, String] Attachment file id
      # @return [BacklogKit::Response] Binary data
      def download_pull_request_attachment(project_id_or_key, repository_id_or_name, pull_request_number, attachment_id)
        get("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/attachments/#{attachment_id}")
      end

      # Remove an attachment file from pull request
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @param repository_id_or_name [Integer, String] Repository id or repository name
      # @param pull_request_number [Integer, String] Pull request number
      # @param attachment_id [Integer, String] Attachment file id
      # @return [BacklogKit::Response] The pull request information
      def remove_pull_request_attachment(project_id_or_key, repository_id_or_name, pull_request_number, attachment_id)
        delete("projects/#{project_id_or_key}/git/repositories/#{repository_id_or_name}/pullRequests/#{pull_request_number}/attachments/#{attachment_id}")
      end
    end
  end
end
