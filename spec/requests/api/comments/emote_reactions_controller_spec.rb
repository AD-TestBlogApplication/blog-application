# frozen_string_literal: true

require 'rails_helper'

module API
  module Comments
    RSpec.describe 'Comments/EmoteReactions API', type: :request do
      let(:user) { create :user }
      let(:comment) { create :comment, user: user }
      let(:post_id) { comment.id }
      let(:headers) { valid_headers(user.id) }

      # Test suite for POST /api/comments/:comment_id/emote_reactions
      describe 'POST /api/comments/:comment_id/emote_reactions' do
        # valid payload
        let(:valid_attributes) { { kind: 'like' }.to_json }

        context 'when the request is valid' do
          before { post "/api/comments/#{comment.id}/emote_reactions", params: valid_attributes, headers: headers }

          it 'creates an emote_reaction' do
            expect(json['emote_reaction']['kind']).to eq('like')
            expect(json['emote_reaction']['user_id']).to eq(user.id)
            expect(json['emote_reaction']['emotionable_id']).to eq(comment.id)
            expect(json['emote_reaction']['emotionable_type']).to eq('Comment')
          end

          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end

        context 'when the request is invalid' do
          before { post "/api/comments/#{comment.id}/emote_reactions", params: { kind: 'invalid' }.to_json, headers: headers }

          it 'returns status code 422' do
            expect(response).to have_http_status(400)
          end

          it 'returns a validation failure message' do
            expect(response.body)
              .to match(/'invalid' is not a valid kind/)
          end
        end
      end
    end
  end
end
