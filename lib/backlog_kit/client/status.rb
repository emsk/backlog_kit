module BacklogKit
  class Client
    # Methods for the Status API
    module Status
      # Get list of statuses
      #
      # @return [BacklogKit::Response] List of statuses
      def get_statuses
        get('statuses')
      end
    end
  end
end
