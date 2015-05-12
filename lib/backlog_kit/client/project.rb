module BacklogKit
  class Client
    module Project
      def get_projects
        get('projects')
      end

      def get_project(project_id_or_key)
        get("projects/#{project_id_or_key}")
      end

      def create_project(key, name, params = {})
        params.merge!(key: key, name: name)
        post('projects', params)
      end

      def update_project(project_id_or_key, params = {})
        patch("projects/#{project_id_or_key}", params)
      end

      def delete_project(project_id_or_key)
        delete("projects/#{project_id_or_key}")
      end

      def download_project_icon(project_id_or_key)
        get("projects/#{project_id_or_key}/image")
      end

      def get_project_activities(project_id_or_key, params = {})
        get("projects/#{project_id_or_key}/activities", params)
      end

      def get_project_users(project_id_or_key)
        get("projects/#{project_id_or_key}/users")
      end

      def add_project_user(project_id_or_key, user_id)
        post("projects/#{project_id_or_key}/users", user_id: user_id)
      end

      def remove_project_user(project_id_or_key, user_id)
        delete("projects/#{project_id_or_key}/users", user_id: user_id)
      end

      def get_project_administrators(project_id_or_key)
        get("projects/#{project_id_or_key}/administrators")
      end

      def add_project_admin_auth(project_id_or_key, user_id)
        post("projects/#{project_id_or_key}/administrators", user_id: user_id)
      end

      def remove_project_admin_auth(project_id_or_key, user_id)
        delete("projects/#{project_id_or_key}/administrators", user_id: user_id)
      end

      def get_issue_types(project_id_or_key)
        get("projects/#{project_id_or_key}/issueTypes")
      end

      def add_issue_type(project_id_or_key, name, color)
        post("projects/#{project_id_or_key}/issueTypes", name: name, color: color)
      end

      def update_issue_type(project_id_or_key, type_id, params = {})
        patch("projects/#{project_id_or_key}/issueTypes/#{type_id}", params)
      end

      def remove_issue_type(project_id_or_key, type_id, substitute_type_id)
        delete("projects/#{project_id_or_key}/issueTypes/#{type_id}", substitute_issue_type_id: substitute_type_id)
      end

      def get_categories(project_id_or_key)
        get("projects/#{project_id_or_key}/categories")
      end

      def add_category(project_id_or_key, name)
        post("projects/#{project_id_or_key}/categories", name: name)
      end

      def update_category(project_id_or_key, category_id, name)
        patch("projects/#{project_id_or_key}/categories/#{category_id}", name: name)
      end

      def remove_category(project_id_or_key, category_id)
        delete("projects/#{project_id_or_key}/categories/#{category_id}")
      end

      def get_versions(project_id_or_key)
        get("projects/#{project_id_or_key}/versions")
      end

      def add_version(project_id_or_key, name, params = {})
        params.merge!(name: name)
        post("projects/#{project_id_or_key}/versions", params)
      end

      def update_version(project_id_or_key, version_id, params = {})
        patch("projects/#{project_id_or_key}/versions/#{version_id}", params)
      end

      def remove_version(project_id_or_key, version_id)
        delete("projects/#{project_id_or_key}/versions/#{version_id}")
      end

      def get_shared_files(project_id_or_key, directory_path = '', params = {})
        get("projects/#{project_id_or_key}/files/metadata/#{directory_path}", params)
      end

      def download_shared_file(project_id_or_key, file_id)
        get("projects/#{project_id_or_key}/files/#{file_id}")
      end

      def get_project_disk_usage(project_id_or_key)
        get("projects/#{project_id_or_key}/diskUsage")
      end

      def get_webhooks(project_id_or_key)
        get("projects/#{project_id_or_key}/webhooks")
      end

      def get_webhook(project_id_or_key, webhook_id)
        get("projects/#{project_id_or_key}/webhooks/#{webhook_id}")
      end

      def add_webhook(project_id_or_key, name, hook_url, params = {})
        params.merge!(name: name, hook_url: hook_url)
        post("projects/#{project_id_or_key}/webhooks", params)
      end

      def update_webhook(project_id_or_key, webhook_id, params = {})
        patch("projects/#{project_id_or_key}/webhooks/#{webhook_id}", params)
      end

      def remove_webhook(project_id_or_key, webhook_id)
        delete("projects/#{project_id_or_key}/webhooks/#{webhook_id}")
      end
    end
  end
end
