# frozen_string_literal: true

module API
  class AuthorizeRequest
    AUTHORIZATION_HEADER = 'Authorization'
    MISSING_TOKEN_ERROR_MESSAGE = 'Missing token'

    def initialize(headers = {})
      @headers = headers
    end

    def call
      { user: user }
    end

    private

    def user
      # check if user is in the database
      # memoize user object
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue ActiveRecord::RecordNotFound => e
      raise ExceptionHandler::InvalidToken, "Invalid token #{e.message}"
    end

    # decode authentication token
    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    # check for token in `Authorization` header
    def http_auth_header
      raise ExceptionHandler::MissingToken, MISSING_TOKEN_ERROR_MESSAGE unless @headers[AUTHORIZATION_HEADER].present?

      @headers[AUTHORIZATION_HEADER].split.last
    end
  end
end
