require 'backlog_kit/response/middleware'

module BacklogKit
  class Response
    class RaiseError < BacklogKit::Response::Middleware
      CODE_ERRORS = {
        1  => BacklogKit::InternalError,
        2  => BacklogKit::LicenceError,
        3  => BacklogKit::LicenceExpiredError,
        4  => BacklogKit::AccessDeniedError,
        5  => BacklogKit::UnauthorizedOperationError,
        6  => BacklogKit::NoResourceError,
        7  => BacklogKit::InvalidRequestError,
        8  => BacklogKit::SpaceOverCapacityError,
        9  => BacklogKit::ResourceOverflowError,
        10 => BacklogKit::TooLargeFileError,
        11 => BacklogKit::AuthenticationError
      }.freeze

      def on_complete(env)
        super
        raise BacklogKit::Error, error_message unless success?
      end

      private

      def success?
        no_content? || !json? || json_body.is_a?(Array) || json_body['errors'].nil?
      end

      def error_message
        messages = []
        json_body['errors'].each.with_index(1) do |error, index|
          klass = CODE_ERRORS[error['code']] || BacklogKit::UnexpectedError
          messages.push(klass.build_error_message(error, index))
        end
        messages.join(', ')
      end

      def json_body
        @json_body ||= JSON.parse(body)
      end
    end

    Faraday::Response.register_middleware(error: RaiseError)
  end
end
