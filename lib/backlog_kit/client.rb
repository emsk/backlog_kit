require 'backlog_kit/version'

module BacklogKit
  class Client
    attr_writer(:space_id, :api_key)

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    def space_id
      @space_id ||= ENV['BACKLOG_SPACE_ID']
    end

    def api_key
      @api_key ||= ENV['BACKLOG_API_KEY']
    end
  end
end
