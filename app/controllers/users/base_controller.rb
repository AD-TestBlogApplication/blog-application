# frozen_string_literal: true

module Users
  class BaseController < ApplicationController
    before_action :set_user

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
