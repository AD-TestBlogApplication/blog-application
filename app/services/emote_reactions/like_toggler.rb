# frozen_string_literal: true

module EmoteReactions
  class LikeToggler
    def initialize(emotionable:, user:)
      @emotionable = emotionable
      @user = user
    end

    def call
      ::EmoteReaction.transaction do
        if like_exists?
          existed_like.destroy!
        else
          remove_dislike
          create_like
        end
      end
    end

    private

    def like_exists?
      !!existed_like
    end

    def existed_like
      @emotionable.emote_reactions.find_by(kind: :like, user: @user)
    end

    def remove_dislike
      @emotionable.emote_reactions.find_by(kind: :dislike, user: @user)&.destroy!
    end

    def create_like
      EmoteReactionCreator.new(
        emotionable: @emotionable, user: @user, kind: :like
      ).call
    end
  end
end
