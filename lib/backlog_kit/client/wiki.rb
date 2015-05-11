module BacklogKit
  class Client
    module Wiki
      def get_wikis(project_id_or_key)
        get('wikis', project_id_or_key: project_id_or_key)
      end

      def get_wiki_count(project_id_or_key)
        get('wikis/count', project_id_or_key: project_id_or_key)
      end

      def get_wiki(wiki_id)
        get("wikis/#{wiki_id}")
      end

      def get_wiki_tags(project_id_or_key)
        get('wikis/tags', project_id_or_key: project_id_or_key)
      end

      def create_wiki(name, content, project_id, params = {})
        params.merge!(name: name, content: content, project_id: project_id)
        post('wikis', params)
      end

      def update_wiki(wiki_id, params = {})
        patch("wikis/#{wiki_id}", params)
      end

      def delete_wiki(wiki_id, params = {})
        delete("wikis/#{wiki_id}", params)
      end

      def get_wiki_shared_files(wiki_id)
        get("wikis/#{wiki_id}/sharedFiles")
      end

      def link_wiki_shared_files(wiki_id, file_ids = [])
        post("wikis/#{wiki_id}/sharedFiles", file_id: file_ids)
      end

      def unlink_wiki_shared_file(wiki_id, file_id)
        delete("wikis/#{wiki_id}/sharedFiles/#{file_id}")
      end

      def get_wiki_histories(wiki_id, params = {})
        get("wikis/#{wiki_id}/history", params)
      end

      def get_wiki_stars(wiki_id)
        get("wikis/#{wiki_id}/stars")
      end
    end
  end
end
