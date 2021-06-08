# frozen_string_literal: true

module API
  module Posts
    class CommentsController < BaseController
      before_action :set_post, only: %i[create]

      def create
        comment = @post.comments.build(comment_params)
        comment.user = current_user
        comment.save!

        response = { comment: comment }
        json_response(response, :created)
      end

      private

      def set_post
        @post = ::Post.find(params[:post_id])
      end

      def comment_params
        params.permit(:content)
      end
    end
  end
end
