module BacklogKit
  class Client
    # Methods for the Resolution API
    module Resolution
      # Get list of resolutions
      #
      # @return [BacklogKit::Response] List of resolutions
      def get_resolutions
        get('resolutions')
      end
    end
  end
end
