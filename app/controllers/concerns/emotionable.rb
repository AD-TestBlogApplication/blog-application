# frozen_string_literal: true

module Emotionable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def create
    @emote_reaction = handle_emote_reaction_creation
    redirect_back fallback_location: root_path
  end

  private

  def emote_reaction_params
    params.require(:emote_reaction).permit(:kind)
  end

  def handle_emote_reaction_creation
    kind = emote_reaction_params[:kind]&.to_sym

    case kind
    when :like
      EmoteReactions::LikeToggler.new(emotionable: @emotionable, user: current_user).call
    when :dislike
      EmoteReactions::DislikeToggler.new(emotionable: @emotionable, user: current_user).call
    end
  end
end
