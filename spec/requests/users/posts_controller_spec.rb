# frozen_string_literal: true

require 'rails_helper'

module Users
  RSpec.describe PostsController, type: :request do
    let(:user) { create :user }

    describe 'GET index' do
      subject { get "/users/#{user.id}/posts" }

      it 'has a 200 status code' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end
