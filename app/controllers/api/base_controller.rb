# frozen_string_literal: true

module API
  class BaseController < ActionController::API
    include Response
    include ExceptionHandler
  end
end
