# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe CommentsController, type: :routing do
    it 'routes to #create as POST' do
      expect(post: '/posts/post_id/comments').to route_to(
        controller: 'posts/comments',
        action: 'create',
        post_id: 'post_id'
      )
    end
  end
end
