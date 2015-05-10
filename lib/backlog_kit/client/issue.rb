module BacklogKit
  class Client
    module Issue
      def get_issues(params = {})
        get('issues', params)
      end

      def get_issue_count(params = {})
        get('issues/count', params)
      end

      def get_issue(issue_id_or_key)
        get("issues/#{issue_id_or_key}")
      end

      def create_issue(summary, params = {})
        params.merge!(summary: summary)
        post('issues', params)
      end

      def update_issue(issue_id_or_key, params = {})
        patch("issues/#{issue_id_or_key}", params)
      end

      def delete_issue(issue_id_or_key)
        delete("issues/#{issue_id_or_key}")
      end

      def get_comments(issue_id_or_key, params = {})
        get("issues/#{issue_id_or_key}/comments", params)
      end

      def get_comment_count(issue_id_or_key)
        get("issues/#{issue_id_or_key}/comments/count")
      end

      def get_comment(issue_id_or_key, comment_id)
        get("issues/#{issue_id_or_key}/comments/#{comment_id}")
      end

      def add_comment(issue_id_or_key, content, params = {})
        params.merge!(content: content)
        post("issues/#{issue_id_or_key}/comments", params)
      end

      def update_comment(issue_id_or_key, comment_id, content)
        patch("issues/#{issue_id_or_key}/comments/#{comment_id}", content: content)
      end

      def get_comment_notifications(issue_id_or_key, comment_id)
        get("issues/#{issue_id_or_key}/comments/#{comment_id}/notifications")
      end

      def add_comment_notification(issue_id_or_key, comment_id, notified_user_ids = [])
        post("issues/#{issue_id_or_key}/comments/#{comment_id}/notifications", notified_user_id: notified_user_ids)
      end

      def get_issue_attachments(issue_id_or_key)
        get("issues/#{issue_id_or_key}/attachments")
      end

      def download_issue_attachment(issue_id_or_key, attachment_id)
        get("issues/#{issue_id_or_key}/attachments/#{attachment_id}")
      end

      def remove_issue_attachment(issue_id_or_key, attachment_id)
        delete("issues/#{issue_id_or_key}/attachments/#{attachment_id}")
      end

      def get_issue_shared_files(issue_id_or_key)
        get("issues/#{issue_id_or_key}/sharedFiles")
      end

      def link_issue_shared_files(issue_id_or_key, file_ids = [])
        post("issues/#{issue_id_or_key}/sharedFiles", file_id: file_ids)
      end

      def unlink_issue_shared_file(issue_id_or_key, file_id)
        delete("issues/#{issue_id_or_key}/sharedFiles/#{file_id}")
      end
    end
  end
end
