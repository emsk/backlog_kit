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
    end
  end
end
