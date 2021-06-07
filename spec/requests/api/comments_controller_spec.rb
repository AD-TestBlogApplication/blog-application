# frozen_string_literal: true

require 'rails_helper'

module API
  RSpec.describe 'Comments API', type: :request do
    let(:user) { create :user }
    let(:comment) { create :comment, user: user }
    let(:headers) { valid_headers(user.id) }

    # Test suite for PUT /api/comments/:id
    describe 'PUT /api/comments/:id' do
      let(:valid_attributes) { { content: 'updated content' }.to_json }

      context 'when the record exists' do
        before { put "/api/comments/#{comment.id}", params: valid_attributes, headers: headers }

        it 'updates the record' do
          expect(response.body).to be_empty
          expect(comment.reload.content).to eq 'updated content'
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        context 'when the request is invalid' do
          before { put "/api/comments/#{comment.id}", params: { content: '' }.to_json, headers: headers }

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

    # Test suite for DELETE /api/comments/:id
    describe 'DELETE /api/comments/:id' do
      before { delete "/api/comments/#{comment.id}", headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
        expect(::Comment.exists?(id: comment.id)).to be false
      end
    end
  end
end
