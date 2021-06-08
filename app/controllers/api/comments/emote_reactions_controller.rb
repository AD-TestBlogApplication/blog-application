# frozen_string_literal: true

module API
  module Comments
    class EmoteReactionsController < BaseController
      before_action :set_comment, only: %i[create]

      def create
        emote_reaction = @comment.emote_reactions.build(emote_reaction_params)
        emote_reaction.user = current_user
        emote_reaction.save!

        response = { emote_reaction: emote_reaction }
        json_response(response, :created)
      end

      private

      def set_comment
        @comment = ::Comment.find(params[:comment_id])
      end

      def emote_reaction_params
        params.permit(:kind)
      end
    end
  end
end
