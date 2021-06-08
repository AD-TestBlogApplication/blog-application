# frozen_string_literal: true

module API
  class AuthenticateUser
    INVALID_CREDENTIALS_ERROR_MESSAGE = 'Invalid credentials'

    def initialize(email, password)
      @password = password
      @user = ::User.find_by(email: email)
    end

    def call
      JsonWebToken.encode(user_id: @user.id) if valid_password?
    end

    private

    attr_reader :email, :password

    # verify user credentials
    def valid_password?
      return true if @user&.valid_password?(password)

      # raise Authentication error if credentials are invalid
      raise ExceptionHandler::AuthenticationError, INVALID_CREDENTIALS_ERROR_MESSAGE
    end
  end
end
