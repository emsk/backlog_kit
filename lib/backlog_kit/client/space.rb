module BacklogKit
  class Client

    # Methods for the Space API
    module Space

      # Get a space
      #
      # @return [BacklogKit::Response] The space information
      def get_space
        get('space')
      end

      # Get list of space activities
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of recent updates in your space
      def get_space_activities(params = {})
        get('space/activities', params)
      end

      # Download a space logo image
      #
      # @return [BacklogKit::Response] Binary image data
      def download_space_icon
        get('space/image')
      end

      # Get a space notification
      #
      # @return [BacklogKit::Response] The notification information
      def get_space_notification
        get('space/notification')
      end

      # Update a space notification
      #
      # @param content [String] Content of the notification
      # @return [BacklogKit::Response] The notification information
      def update_space_notification(content)
        put('space/notification', content: content)
      end

      # Get a space disk usage
      #
      # @return [BacklogKit::Response] The disk usage
      def get_space_disk_usage
        get('space/diskUsage')
      end

      # Upload attachment file for issue or wiki
      #
      # @param file_path [String] Path of the file
      # @return [BacklogKit::Response] The file information
      def upload_attachment(file_path)
        payload = { file: Faraday::UploadIO.new(file_path, 'application/octet-stream') }
        post('space/attachment', payload)
      end
    end
  end
end
