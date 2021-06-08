# frozen_string_literal: true

module API
  class PostsController < BaseController
    skip_before_action :authorize_request, only: %i[index show]

    before_action :set_post, only: %i[show]
    before_action :set_current_user_post, only: %i[update destroy]

    def index
      posts = Post.includes(:user).order(created_at: :desc)
      json_response(posts)
    end

    def create
      post = current_user.posts.create!(post_params)
      json_response({ post: post }, :created)
    end

    def show
      json_response({ post: @post })
    end

    def update
      @post.update!(post_params)
      head :no_content
    end

    def destroy
      @post.destroy!
      head :no_content
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:content)
    end

    def set_current_user_post
      @post = current_user.posts.find(params[:id])
    end
  end
end
