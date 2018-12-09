require 'backlog_kit/response/middleware'
require 'backlog_kit/resource_file'

module BacklogKit
  class Response
    class FileParser < BacklogKit::Response::Middleware
      def on_complete(env)
        super
        env.body = BacklogKit::ResourceFile.new(decoded_filename, body) if file?
      end

      private

      def file?
        !(no_content? || json?)
      end

      def decoded_filename
        match_data = content_disposition.match(/=(.*)''(.+)\z/)
        encode = match_data[1]
        filename = match_data[2]
        return filename if encode.empty?

        URI.decode_www_form_component(filename, encode)
      end

      def content_disposition
        headers['content-disposition']
      end
    end

    Faraday::Response.register_middleware(file_parser: FileParser)
  end
end
