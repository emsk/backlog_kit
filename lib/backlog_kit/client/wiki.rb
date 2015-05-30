module BacklogKit
  class Client

    # Methods for the Wiki API
    module Wiki

      # Get list of wiki pages
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of pages
      def get_wikis(project_id_or_key)
        get('wikis', project_id_or_key: project_id_or_key)
      end

      # Get number of wiki pages
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] Number of pages
      def get_wiki_count(project_id_or_key)
        get('wikis/count', project_id_or_key: project_id_or_key)
      end

      # Get a wiki page
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @return [BacklogKit::Response] The page information
      def get_wiki(wiki_id)
        get("wikis/#{wiki_id}")
      end

      # Get list of wiki page tags
      #
      # @param project_id_or_key [Integer, String] Project id or project key
      # @return [BacklogKit::Response] List of tags
      def get_wiki_tags(project_id_or_key)
        get('wikis/tags', project_id_or_key: project_id_or_key)
      end

      # Create a new wiki page
      #
      # @param name [String] Name of the page
      # @param content [String] Content of the page
      # @param project_id [Integer, String] Project id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The page information
      def create_wiki(name, content, project_id, params = {})
        params.merge!(name: name, content: content, project_id: project_id)
        post('wikis', params)
      end

      # Update a wiki page
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The page information
      def update_wiki(wiki_id, params = {})
        patch("wikis/#{wiki_id}", params)
      end

      # Delete a wiki page
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The page information
      def delete_wiki(wiki_id, params = {})
        delete("wikis/#{wiki_id}", params)
      end

      # Get list of shared files on wiki
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @return [BacklogKit::Response] List of files
      def get_wiki_shared_files(wiki_id)
        get("wikis/#{wiki_id}/sharedFiles")
      end

      # Link shared files to wiki
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @param file_ids [Array] List of file ids
      # @return [BacklogKit::Response] List of files
      def link_wiki_shared_files(wiki_id, file_ids = [])
        post("wikis/#{wiki_id}/sharedFiles", file_id: file_ids)
      end

      # Unlink a shared file on wiki
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @param file_id [Integer, String] Shared file id
      # @return [BacklogKit::Response] The file information
      def unlink_wiki_shared_file(wiki_id, file_id)
        delete("wikis/#{wiki_id}/sharedFiles/#{file_id}")
      end

      # Get list of wiki histories
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of histories
      def get_wiki_histories(wiki_id, params = {})
        get("wikis/#{wiki_id}/history", params)
      end

      # Get list of wiki stars
      #
      # @param wiki_id [Integer, String] Wiki page id
      # @return [BacklogKit::Response] List of stars
      def get_wiki_stars(wiki_id)
        get("wikis/#{wiki_id}/stars")
      end
    end
  end
end
