# frozen_string_literal: true

require 'rails_helper'

module API
  RSpec.describe 'Posts API', type: :request do
    let(:user) { create :user }
    let!(:posts) { create_list(:post, 10, user: user) }
    let(:post_id) { posts.first.id }
    let(:headers) { valid_headers(user.id) }

    # Test suite for GET /api/posts
    describe 'GET /api/posts' do
      # make HTTP get request before each example
      before { get '/api/posts' }

      it 'returns posts' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
        expect(json.first['id']).to eq posts.last.id
        expect(json.last['id']).to eq posts.first.id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    # Test suite for GET /api/posts/:id
    describe 'GET /api/posts/:id' do
      before { get "/api/posts/#{post_id}" }

      context 'when the record exists' do
        it 'returns the post' do
          expect(json).not_to be_empty
          expect(json['post']['id']).to eq(post_id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:post_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Post/)
        end
      end
    end

    # Test suite for POST /api/posts
    describe 'POST /api/posts' do
      # valid payload
      let(:valid_attributes) { { content: 'test' }.to_json }

      context 'when the request is valid' do
        before { post '/api/posts', params: valid_attributes, headers: headers }

        it 'creates a post' do
          expect(json['post']['content']).to eq('test')
          expect(json['post']['user_id']).to eq(user.id)
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post '/api/posts', params: { content: '' }.to_json, headers: headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Content can't be blank/)
        end
      end
    end

    # Test suite for PUT /api/posts/:id
    describe 'PUT /api/posts/:id' do
      let(:valid_attributes) { { content: 'updated content' }.to_json }

      context 'when the record exists' do
        before { put "/api/posts/#{post_id}", params: valid_attributes, headers: headers }

        it 'updates the record' do
          expect(response.body).to be_empty
          expect(posts.first.reload.content).to eq 'updated content'
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        context 'when the request is invalid' do
          before { put "/api/posts/#{post_id}", params: { content: '' }.to_json, headers: headers }

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

    # Test suite for DELETE /api/posts/:id
    describe 'DELETE /api/posts/:id' do
      before { delete "/api/posts/#{post_id}", headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
        expect(::Post.exists?(id: post_id)).to be false
      end
    end
  end
end
