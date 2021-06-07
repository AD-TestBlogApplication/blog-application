# frozen_string_literal: true

require 'rails_helper'

module API
  RSpec.describe 'Posts/Comments API', type: :request do
    let(:user) { create :user }
    let(:post_record) { create :post, user: user }
    let(:post_id) { post_record.id }
    let(:headers) { valid_headers(user.id) }

    # Test suite for POST /api/posts/:post_id/comments
    describe 'POST /api/posts/:post_id/comments' do
      # valid payload
      let(:valid_attributes) { { content: 'test' }.to_json }

      context 'when the request is valid' do
        before { post "/api/posts/#{post_id}/comments", params: valid_attributes, headers: headers }

        it 'creates a comment' do
          expect(json['comment']['content']).to eq('test')
          expect(json['comment']['user_id']).to eq(user.id)
          expect(json['comment']['commentable_id']).to eq(post_id)
          expect(json['comment']['commentable_type']).to eq('Post')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post "/api/posts/#{post_id}/comments", params: { content: '' }.to_json, headers: headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Content can't be blank/)
        end
      end
    end
  end
end
