module BacklogKit
  class Error < StandardError
    def self.build_error_message(response, index)
      message = "[ERROR #{index}] "
      message += "#{self.name.demodulize} - #{response['message']} (CODE: #{response['code']})"
      more_info = response['moreInfo'].to_s
      message += " (MORE INFO: #{more_info})" unless more_info.empty?
      message
    end
  end

  class ConnectionError < Error; end
  class UnexpectedError < Error; end
  class InternalError < Error; end
  class LicenceError < Error; end
  class LicenceExpiredError < Error; end
  class AccessDeniedError < Error; end
  class UnauthorizedOperationError < Error; end
  class NoResourceError < Error; end
  class InvalidRequestError < Error; end
  class SpaceOverCapacityError < Error; end
  class ResourceOverflowError < Error; end
  class TooLargeFileError < Error; end
  class AuthenticationError < Error; end
end
