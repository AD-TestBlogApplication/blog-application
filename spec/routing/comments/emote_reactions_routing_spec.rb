# frozen_string_literal: true

require 'rails_helper'

module Comments
  RSpec.describe EmoteReactionsController, type: :routing do
    it 'routes to #create as POST' do
      expect(post: '/comments/comment_id/emote_reactions').to route_to(
        controller: 'comments/emote_reactions',
        action: 'create',
        comment_id: 'comment_id'
      )
    end
  end
end
