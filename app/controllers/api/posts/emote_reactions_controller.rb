# frozen_string_literal: true

module API
  module Posts
    class EmoteReactionsController < BaseController
      before_action :set_post, only: %i[create]

      def create
        emote_reaction = @post.emote_reactions.build(emote_reaction_params)
        emote_reaction.user = current_user
        emote_reaction.save!

        response = { emote_reaction: emote_reaction }
        json_response(response, :created)
      end

      private

      def set_post
        @post = ::Post.find(params[:post_id])
      end

      def emote_reaction_params
        params.permit(:kind)
      end
    end
  end
end
