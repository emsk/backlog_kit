module BacklogKit
  class Response
    class Middleware < Faraday::Response::Middleware
      attr_reader(:headers, :status, :body)

      def on_complete(env)
        @headers = env.response_headers
        @status  = env.status
        @body    = env.body
      end

      private

      def no_content?
        status == 204
      end

      def json?
        !!content_type.match(/application\/json/)
      end

      def content_type
        headers['content-type']
      end
    end
  end
end
