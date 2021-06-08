# frozen_string_literal: true

module API
  module ExceptionHandler
    extend ActiveSupport::Concern

    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end

    class MissingToken < StandardError; end

    class InvalidToken < StandardError; end

    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ message: e.message }, :not_found)
      end

      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
      rescue_from ArgumentError, with: :bad_request
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized
      rescue_from ExceptionHandler::MissingToken, with: :unauthorized
      rescue_from ExceptionHandler::InvalidToken, with: :unauthorized
    end

    private

    # JSON response with message; Status code 422 - unprocessable entity
    def unprocessable_entity(error)
      json_response({ message: error.message }, :unprocessable_entity)
    end

    # JSON response with message; Status code 401 - Unauthorized
    def unauthorized(error)
      json_response({ message: error.message }, :unauthorized)
    end

    # JSON response with message; Status code 400 - bad request
    def bad_request(error)
      json_response({ message: error.message }, :bad_request)
    end
  end
end
