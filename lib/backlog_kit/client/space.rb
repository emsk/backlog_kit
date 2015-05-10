module BacklogKit
  class Client
    module Space
      def get_space
        get('space')
      end

      def get_space_activities(params = {})
        get('space/activities', params)
      end

      def download_space_icon
        get('space/image')
      end

      def get_space_notification
        get('space/notification')
      end

      def update_space_notification(content)
        put('space/notification', content: content)
      end

      def get_space_disk_usage
        get('space/diskUsage')
      end

      def upload_attachment(file_path)
        payload = { file: Faraday::UploadIO.new(file_path, 'application/octet-stream') }
        post('space/attachment', payload)
      end
    end
  end
end
