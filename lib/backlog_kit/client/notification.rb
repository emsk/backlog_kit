module BacklogKit
  class Client
    # Methods for the Notification API
    module Notification
      # Get list of own notifications
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] List of notifications
      def get_notifications(params = {})
        get('notifications', params)
      end

      # Get number of own notifications
      #
      # @param params [Hash] Request parameters
      # @return [BacklogKit::Response] Number of notifications
      def get_notification_count(params = {})
        get('notifications/count', params)
      end

      # Reset unread notification count
      #
      # @return [BacklogKit::Response] Number of notifications
      def reset_unread_notification_count
        post('notifications/markAsRead')
      end

      # Mark a notification as read
      #
      # @param notification_id [Integer, String] Notification id
      # @return [BacklogKit::Response] No content response
      def mark_as_read_notification(notification_id)
        post("notifications/#{notification_id}/markAsRead")
      end
    end
  end
end
