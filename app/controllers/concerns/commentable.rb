# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
