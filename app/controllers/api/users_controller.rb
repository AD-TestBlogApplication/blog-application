# frozen_string_literal: true

module API
  class UsersController < BaseController
    # return auth token once user is authenticated
    def authenticate
      auth_token = AuthenticateUser.new(
        sign_in_params[:email], sign_in_params[:password]
      ).call
      json_response(auth_token: auth_token)
    end

    def create
      user = User.new(user_params)
      user.role = :client
      user.save!

      json_response({ user: user }, :created)
    end

    private

    def sign_in_params
      params.permit(:email, :password)
    end

    def user_params
      params.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name
      )
    end
  end
end
