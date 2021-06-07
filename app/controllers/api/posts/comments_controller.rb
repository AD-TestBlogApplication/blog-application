# frozen_string_literal: true

module API
  module Posts
    class CommentsController < BaseController
      def create
        comment = @post.comments.build(comment_params)
        comment.user = current_user
        comment.save!

        response = { comment: comment }
        json_response(response, :created)
      end

      private

      def comment_params
        params.permit(:content)
      end
    end
  end
end
