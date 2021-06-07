# frozen_string_literal: true

module EmoteReactionsHelper
  def like_button(emotionable, type: :button)
    render partial: 'emote_reactions/like_button', locals: { emotionable: emotionable, type: type }
  end

  def dislike_button(emotionable, type: :button)
    render partial: 'emote_reactions/dislike_button', locals: { emotionable: emotionable, type: type }
  end

  def emote_reacted?(emotionable, user:, kind:)
    'active' if emotionable.emote_reactions.exists?(kind: kind, user: user)
  end
end
