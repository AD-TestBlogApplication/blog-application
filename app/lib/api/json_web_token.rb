# frozen_string_literal: true

module API
  class JsonWebToken
    # secret to encode and decode token
    HMAC_SECRET = Rails.application.secrets.secret_key_base
    TOKEN_LIFE_TIME = 24.hours

    def self.encode(payload, exp = TOKEN_LIFE_TIME.from_now)
      # set expiry from creation time
      payload[:exp] = exp.to_i
      # sign token with application secret
      ::JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
      # get payload; first index in decoded Array
      body = ::JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
      # rescue from all decode errors
    rescue ::JWT::DecodeError => e
      # raise custom error to be handled by custom handler
      raise ExceptionHandler::InvalidToken, e.message
    end
  end
end
