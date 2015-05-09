module BacklogKit
  class Client
    module Group
      def get_groups(params = {})
        get('groups', params)
      end

      def get_group(group_id)
        get("groups/#{group_id}")
      end

      def create_group(name, params = {})
        params.merge!(name: name)
        post('groups', params)
      end

      def update_group(group_id, params = {})
        patch("groups/#{group_id}", params)
      end

      def delete_group(group_id)
        delete("groups/#{group_id}")
      end
    end
  end
end
