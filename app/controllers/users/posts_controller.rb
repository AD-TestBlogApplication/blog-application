# frozen_string_literal: true

module Users
  class PostsController < BaseController
    before_action :authenticate_user!, only: %i[new create edit update destroy]
    before_action :set_post, only: %i[show]
    before_action :set_current_user_post, only: %i[edit update destroy]

    def index
      @posts = @user.posts.order(created_at: :desc).limit(100)
    end
  end
end
