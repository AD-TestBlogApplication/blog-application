# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to @comment.commentable
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
