# frozen_string_literal: true

module API
  class CommentsController < BaseController
    before_action :set_comment

    def update
      @comment.update!(comment_params)
      head :no_content
    end

    def destroy
      @comment.destroy!
      head :no_content
    end

    private

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.permit(:content)
    end
  end
end
