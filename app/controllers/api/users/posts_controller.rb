# frozen_string_literal: true

module API
  module Users
    class PostsController < BaseController
      skip_before_action :authorize_request, only: %i[index]
      before_action :set_user, only: %i[index]

      def index
        posts = @user.posts.order(created_at: :desc)

        response = { posts: posts }
        json_response(response)
      end

      private

      def set_user
        @user = ::User.find(params[:user_id])
      end
    end
  end
end
