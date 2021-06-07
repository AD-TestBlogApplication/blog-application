# frozen_string_literal: true

module Comments
  class EmoteReactionsController < ApplicationController
    include Emotionable

    before_action :set_emotionable

    private

    def set_emotionable
      @emotionable = Comment.find(params[:comment_id])
    end
  end
end
