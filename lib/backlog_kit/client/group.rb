module BacklogKit
  class Client
    # Methods for the Group API
    module Group
      # Get list of groups
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of groups
      def get_groups(params = {})
        get('groups', params)
      end

      # Get a group
      #
      # @param group_id [Integer, String] Group id
      # @return [BacklogKit::Response] The group information
      def get_group(group_id)
        get("groups/#{group_id}")
      end

      # Create a new group
      #
      # @param name [String] Group name
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The group information
      def create_group(name, params = {})
        params[:name] = name
        post('groups', params)
      end

      # Update a group
      #
      # @param group_id [Integer, String] Group id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The group information
      def update_group(group_id, params = {})
        patch("groups/#{group_id}", params)
      end

      # Delete a group
      #
      # @param group_id [Integer, String] Group id
      # @return [BacklogKit::Response] The group information
      def delete_group(group_id)
        delete("groups/#{group_id}")
      end
    end
  end
end
