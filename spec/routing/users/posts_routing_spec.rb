# frozen_string_literal: true

require 'rails_helper'

module Users
  RSpec.describe PostsController, type: :routing do
    it 'routes to #index as GET' do
      expect(get: '/users/user_id/posts').to route_to(
        controller: 'users/posts',
        action: 'index',
        user_id: 'user_id'
      )
    end
  end
end
