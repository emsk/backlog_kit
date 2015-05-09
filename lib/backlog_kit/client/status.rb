module BacklogKit
  class Client
    module Status
      def get_statuses
        get('statuses')
      end
    end
  end
end
