# frozen_string_literal: true

module Posts
  class EmoteReactionsController < ApplicationController
    include Emotionable

    before_action :set_emotionable

    private

    def set_emotionable
      @emotionable = Post.find(params[:post_id])
    end
  end
end
