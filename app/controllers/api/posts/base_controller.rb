# frozen_string_literal: true

module API
  module Posts
    class BaseController < API::BaseController
      before_action :set_post

      private

      def set_post
        @post = current_user.posts.find(params[:post_id])
      end
    end
  end
end
