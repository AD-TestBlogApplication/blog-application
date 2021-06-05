# frozen_string_literal: true

module EmoteReactions
  class DislikeToggler
    def initialize(emotionable:, user:)
      @emotionable = emotionable
      @user = user
    end

    def call
      ::EmoteReaction.transaction do
        if dislike_exists?
          existed_dislike.destroy!
        else
          remove_like
          create_dislike
        end
      end
    end

    private

    def dislike_exists?
      !!existed_dislike
    end

    def existed_dislike
      @emotionable.emote_reactions.find_by(kind: :dislike, user: @user)
    end

    def remove_like
      @emotionable.emote_reactions.find_by(kind: :like, user: @user)&.destroy!
    end

    def create_dislike
      EmoteReactionCreator.new(
        emotionable: @emotionable, user: @user, kind: :dislike
      ).call
    end
  end
end
