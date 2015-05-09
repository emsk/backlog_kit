module BacklogKit
  class Client
    module Star
      def add_issue_star(issue_id)
        post('stars', issue_id: issue_id)
      end

      def add_issue_comment_star(comment_id)
        post('stars', comment_id: comment_id)
      end

      def add_wiki_star(wiki_id)
        post('stars', wiki_id: wiki_id)
      end
    end
  end
end
