module BacklogKit
  class Client
    # Methods for the Team API
    module Team
      # Get list of teams
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of teams
      def get_teams(params = {})
        get('teams', params)
      end

      # Get a team
      #
      # @param team_id [Integer, String] Team id
      # @return [BacklogKit::Response] The team information
      def get_team(team_id)
        get("teams/#{team_id}")
      end

      # Create a new team
      #
      # @param name [String] Team name
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The team information
      def create_team(name, params = {})
        params[:name] = name
        post('teams', params)
      end

      # Update a team
      #
      # @param team_id [Integer, String] Team id
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] The team information
      def update_team(team_id, params = {})
        patch("teams/#{team_id}", params)
      end

      # Delete a team
      #
      # @param team_id [Integer, String] Team id
      # @return [BacklogKit::Response] The team information
      def delete_team(team_id)
        delete("teams/#{team_id}")
      end

      # Download a team icon image
      #
      # @param team_id [Integer, String] Team id
      # @return [BacklogKit::Response] Binary image data
      def download_team_icon(team_id)
        get("teams/#{team_id}/icon")
      end
    end
  end
end
