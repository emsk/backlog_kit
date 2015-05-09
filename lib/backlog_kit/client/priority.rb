module BacklogKit
  class Client
    module Priority
      def get_priorities
        get('priorities')
      end
    end
  end
end
