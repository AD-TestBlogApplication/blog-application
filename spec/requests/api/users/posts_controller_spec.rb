# frozen_string_literal: true

require 'rails_helper'

module API
  module Users
    RSpec.describe 'Users/Posts API', type: :request do
      let(:user) { create :user }
      let(:headers) { valid_headers(user.id) }

      # Test suite for GET /api/users/:user_id/posts
      describe 'GET /api/users/:user_id/posts' do
        let!(:user_posts) { create_list :post, 2, user: user }
        let!(:other_posts) { create_list :post, 2 }

        before { get "/api/users/#{user.id}/posts" }

        it 'returns posts' do
          # Note `json` is a custom helper to parse JSON responses
          expect(json).not_to be_empty
          expect(json['posts'].size).to eq(2)
          expect(json['posts'].first['id']).to eq user_posts.last.id
          expect(json['posts'].last['id']).to eq user_posts.first.id
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
