module BacklogKit
  class Client

    # Methods for the Star API
    module Star

      # Add a star to an issue
      #
      # @param issue_id [Integer, String] Issue id
      # @return [BacklogKit::Response] No content response
      def add_issue_star(issue_id)
        post('stars', issue_id: issue_id)
      end

      # Add a star to an issue comment
      #
      # @param comment_id [Integer, String] Comment id
      # @return [BacklogKit::Response] No content response
      def add_issue_comment_star(comment_id)
        post('stars', comment_id: comment_id)
      end

      # Add a star to a wiki page
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @return [BacklogKit::Response] No content response
      def add_wiki_star(wiki_id)
        post('stars', wiki_id: wiki_id)
      end

      # Add a star to a pull request
      #
      # @param pull_request_id [Integer, String] Pull request id
      # @return [BacklogKit::Response] No content response
      def add_pull_request_star(pull_request_id)
        post('stars', pull_request_id: pull_request_id)
      end

      # Add a star to a pull request comment
      #
      # @param pull_request_comment_id [Integer, String] Pull request comment id
      # @return [BacklogKit::Response] No content response
      def add_pull_request_comment_star(pull_request_comment_id)
        post('stars', pull_request_comment_id: pull_request_comment_id)
      end
    end
  end
end
