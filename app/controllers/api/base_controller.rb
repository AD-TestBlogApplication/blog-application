# frozen_string_literal: true

module API
  class BaseController < ActionController::API
    include Response
    include ExceptionHandler

    attr_reader :current_user

    before_action :authorize_request

    private

    def authorize_request
      @current_user = AuthorizeRequest.new(request.headers).call.fetch(:user)
    end
  end
end
