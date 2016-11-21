module BacklogKit
  class Client
    # Methods for the Watching API
    module Watching
      # Get list of watchings
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of watchings
      def get_watchings(user_id, params = {})
        get("users/#{user_id}/watchings", params)
      end

      # Get number of watchings
      #
      # @param user_id [Integer, String] User id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] Number of watchings
      def get_watching_count(user_id, params = {})
        get("users/#{user_id}/watchings/count", params)
      end

      # Get a watching
      #
      # @param watching_id [Integer, String] Watching id
      # @return [BacklogKit::Response] The watching information
      def get_watching(watching_id)
        get("watchings/#{watching_id}")
      end

      # Add a watching
      #
      # @param issue_id_or_key [Integer, String] Issue id or Issue key
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The watching information
      def add_watching(issue_id_or_key, params = {})
        params[:issue_id_or_key] = issue_id_or_key
        post('watchings', params)
      end

      # Update a watching
      #
      # @param watching_id [Integer, String] Watching id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The watching information
      def update_watching(watching_id, params = {})
        patch("watchings/#{watching_id}", params)
      end

      # Remove a watching
      #
      # @param watching_id [Integer, String] Watching id
      # @return [BacklogKit::Response] The watching information
      def remove_watching(watching_id)
        delete("watchings/#{watching_id}")
      end

      # Mark watchings as read
      #
      # @param user_id [Integer, String] User id
      # @return [BacklogKit::Response] No content response
      def mark_as_read_watchings(user_id)
        post("users/#{user_id}/watchings/markAsChecked")
      end

      # Mark a watching as read
      #
      # @param watching_id [Integer, String] Watching id
      # @return [BacklogKit::Response] No content response
      def mark_as_read_watching(watching_id)
        post("watchings/#{watching_id}/markAsRead")
      end
    end
  end
end
