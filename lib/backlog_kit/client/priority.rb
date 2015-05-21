module BacklogKit
  class Client

    # Methods for the Priority API
    module Priority

      # Get list of priorities
      #
      # @return [BacklogKit::Response] List of priorities
      def get_priorities
        get('priorities')
      end
    end
  end
end
