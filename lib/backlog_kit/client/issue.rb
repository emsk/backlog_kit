module BacklogKit
  class Client
    # Methods for the Issue API
    module Issue
      # Get list of issues
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of issues
      def get_issues(params = {})
        get('issues', params)
      end

      # Get number of issues
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] Number of issues
      def get_issue_count(params = {})
        get('issues/count', params)
      end

      # Get an issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @return [BacklogKit::Response] The issue information
      def get_issue(issue_id_or_key)
        get("issues/#{issue_id_or_key}")
      end

      # Create a new issue
      #
      # @param summary [String] Summary of the issue
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The issue information
      def create_issue(summary, params = {})
        params.merge!(summary: summary)
        post('issues', params)
      end

      # Update an issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The issue information
      def update_issue(issue_id_or_key, params = {})
        patch("issues/#{issue_id_or_key}", params)
      end

      # Delete an issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @return [BacklogKit::Response] The issue information
      def delete_issue(issue_id_or_key)
        delete("issues/#{issue_id_or_key}")
      end

      # Get list of comments in issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of comments
      def get_comments(issue_id_or_key, params = {})
        get("issues/#{issue_id_or_key}/comments", params)
      end

      # Get number of comments in issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @return [BacklogKit::Response] Number of comments
      def get_comment_count(issue_id_or_key)
        get("issues/#{issue_id_or_key}/comments/count")
      end

      # Get a comment in issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param comment_id [Integer, String] Comment id
      # @return [BacklogKit::Response] The comment information
      def get_comment(issue_id_or_key, comment_id)
        get("issues/#{issue_id_or_key}/comments/#{comment_id}")
      end

      # Add a comment to an issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param content [String] Content of the comment
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The comment information
      def add_comment(issue_id_or_key, content, params = {})
        params.merge!(content: content)
        post("issues/#{issue_id_or_key}/comments", params)
      end

      # Update a comment in issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param comment_id [Integer, String] Comment id
      # @param content [String] Content of the comment
      # @return [BacklogKit::Response] The comment information
      def update_comment(issue_id_or_key, comment_id, content)
        patch("issues/#{issue_id_or_key}/comments/#{comment_id}", content: content)
      end

      # Get list of comment notifications
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param comment_id [Integer, String] Comment id
      # @return [BacklogKit::Response] List of notifications
      def get_comment_notifications(issue_id_or_key, comment_id)
        get("issues/#{issue_id_or_key}/comments/#{comment_id}/notifications")
      end

      # Add notifications to an comment
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param comment_id [Integer, String] Comment id
      # @param notified_user_ids [Array] List of notified user ids
      # @return [BacklogKit::Response] The notification information
      def add_comment_notification(issue_id_or_key, comment_id, notified_user_ids = [])
        post("issues/#{issue_id_or_key}/comments/#{comment_id}/notifications", notified_user_id: notified_user_ids)
      end

      # Get list of attachment files on issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @return [BacklogKit::Response] List of files
      def get_issue_attachments(issue_id_or_key)
        get("issues/#{issue_id_or_key}/attachments")
      end

      # Download an attachment file on issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param attachment_id [Integer, String] Attachment file id
      # @return [BacklogKit::Response] Binary data
      def download_issue_attachment(issue_id_or_key, attachment_id)
        get("issues/#{issue_id_or_key}/attachments/#{attachment_id}")
      end

      # Remove an attachment file from issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param attachment_id [Integer, String] Attachment file id
      # @return [BacklogKit::Response] The issue information
      def remove_issue_attachment(issue_id_or_key, attachment_id)
        delete("issues/#{issue_id_or_key}/attachments/#{attachment_id}")
      end

      # Get list of shared files on issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @return [BacklogKit::Response] List of files
      def get_issue_shared_files(issue_id_or_key)
        get("issues/#{issue_id_or_key}/sharedFiles")
      end

      # Link shared files to an issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param file_ids [Array] List of file ids
      # @return [BacklogKit::Response] List of files
      def link_issue_shared_files(issue_id_or_key, file_ids = [])
        post("issues/#{issue_id_or_key}/sharedFiles", file_id: file_ids)
      end

      # Unlink a shared file on issue
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param file_id [Integer, String] Shared file id
      # @return [BacklogKit::Response] The file information
      def unlink_issue_shared_file(issue_id_or_key, file_id)
        delete("issues/#{issue_id_or_key}/sharedFiles/#{file_id}")
      end
    end
  end
end
