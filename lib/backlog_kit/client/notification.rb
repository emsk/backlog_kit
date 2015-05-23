module BacklogKit
  class Client
    module Notification
      def get_notifications(params = {})
        get('notifications', params)
      end

      def get_notification_count(params = {})
        get('notifications/count', params)
      end

      def reset_unread_notification_count
        post('notifications/markAsRead')
      end

      def mark_as_read_notification(notification_id)
        post("notifications/#{notification_id}/markAsRead")
      end
    end
  end
end
