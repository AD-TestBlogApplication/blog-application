# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe EmoteReactionsController, type: :routing do
    it 'routes to #create as POST' do
      expect(post: '/posts/post_id/emote_reactions').to route_to(
        controller: 'posts/emote_reactions',
        action: 'create',
        post_id: 'post_id'
      )
    end
  end
end
