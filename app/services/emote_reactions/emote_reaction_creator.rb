# frozen_string_literal: true

module EmoteReactions
  class EmoteReactionCreator
    def initialize(emotionable:, user:, kind:)
      @emotionable = emotionable
      @user = user
      @kind = kind
    end

    def call
      @emotionable.emote_reactions.create!(kind: @kind, user: @user)
    end
  end
end
