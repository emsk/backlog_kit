require 'backlog_kit/resource'

module BacklogKit
  class Response
    attr_reader(:headers, :status, :body)

    def initialize(response)
      @headers = process(response.headers)
      @status  = process(response.status)
      @body    = process(response.body)
    end

    private

    def process(raw)
      case raw
      when Hash   then Resource.new(raw)
      when Array  then raw.map { |hash| process(hash) }
      when String then Resource.new
      else raw
      end
    end
  end
end
