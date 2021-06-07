# frozen_string_literal: true

require 'rails_helper'

module API
  RSpec.describe UsersController, type: :request do
    # Authentication test suite
    describe 'POST /api/users/sign_in' do
      # create test user
      let!(:user) { create(:user) }
      # set headers for authorization
      let(:headers) { valid_headers(user.id).except('Authorization') }
      # set test valid and invalid credentials
      let(:valid_credentials) do
        {
          email: user.email,
          password: user.password
        }.to_json
      end
      let(:invalid_credentials) do
        {
          email: 'invalid_email@test',
          password: 'invalid_password'
        }.to_json
      end

      # returns auth token when request is valid
      context 'When request is valid' do
        before { post '/api/users/sign_in', params: valid_credentials, headers: headers }

        it 'returns an authentication token' do
          expect(json['auth_token']).not_to be_nil
        end
      end

      # returns failure message when request is invalid
      context 'When request is invalid' do
        before { post '/api/users/sign_in', params: invalid_credentials, headers: headers }

        it 'returns a failure message' do
          expect(json['message']).to match(/Invalid credentials/)
        end
      end
    end

    # User signup test suite
    describe 'POST /signup' do
      let(:user) { build(:user) }
      let(:headers) { valid_headers(user.id).except('Authorization') }
      let(:valid_attributes) { attributes_for(:user, password_confirmation: user.password) }

      context 'when valid request' do
        before { post '/api/users/sign_up', params: valid_attributes.to_json, headers: headers }

        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end

        it 'returns an user json' do
          expect(json['user']['id']).to eq User.last.id
        end
      end

      context 'when invalid request' do
        before { post '/api/users/sign_up', params: {}, headers: headers }

        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end

        it 'returns failure message' do
          expect(json['message']).to match(/Validation failed/)
        end
      end
    end
  end
end
