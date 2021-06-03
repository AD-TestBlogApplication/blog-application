# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET index' do
    subject { get '/posts' }

    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    subject { get '/posts/new' }

    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end

    context 'as signed in user' do
      before { sign_in create(:user) }

      it 'has a 200 status code' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST create' do
    subject { post '/posts' }

    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end

    it 'does not create post' do
      expect { subject }.not_to change(Post, :count)
    end

    context 'as signed in user' do
      subject { post '/posts', params: params }

      let(:current_user) { create(:user) }

      before { sign_in current_user }

      context 'without post params' do
        let(:params) { nil }

        it 'raises an error' do
          expect { subject }.to raise_exception(
            ActionController::ParameterMissing,
            /param is missing or the value is empty: post/
          )
        end
      end

      context 'with valid params' do
        let(:params) { { post: { content: 'test' } } }

        it 'creates post' do
          expect { subject }.to change(Post, :count).by(1)
        end

        it 'saves post to current user' do
          expect { subject }.to change { current_user.posts.count }.by(1)
        end

        it 'saves post parameters' do
          subject
          expect(assigns[:post]).to have_attributes(
            user_id: current_user.id,
            content: 'test'
          )
        end

        it 'has a 302 status code' do
          subject
          expect(response.status).to eq(302)
        end

        it 'redirects to post page' do
          expect(subject).to redirect_to "/posts/#{assigns[:post].id}"
        end
      end

      context 'with invalid params' do
        let(:params) { { post: { content: '' } } }

        it 'has a 200 status code' do
          subject
          expect(response.status).to eq(200)
        end

        it 'renders new post template' do
          subject
          expect(response).to render_template(:new)
        end

        it 'does not create post' do
          expect { subject }.not_to change(Post, :count)
        end
      end
    end
  end

  describe 'GET show' do
    subject { get "/posts/#{post.id}" }

    let(:post) { create :post }

    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe 'GET edit' do
    subject { get "/posts/#{post.id}/edit" }

    let(:post) { create :post }

    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end

    context 'as signed in user and an owner of a post' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:post) { create :post, user: current_user }

      it 'has a 200 status code' do
        subject
        expect(response.status).to eq(200)
      end
    end

    context 'as signed in user but not an owner of a post' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:post_owner) { create(:user) }
      let(:post) { create :post, user: post_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Post with 'id'=#{post.id}/
        )
      end
    end
  end

  describe 'PUT update' do
    subject { put "/posts/#{post.id}" }

    let(:post) { create :post }

    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end

    context 'as signed in user and an owner of a post' do
      subject { put "/posts/#{post.id}", params: params }

      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:post) { create :post, user: current_user }

      context 'without post params' do
        let(:params) { nil }

        it 'raises an error' do
          expect { subject }.to raise_exception(
            ActionController::ParameterMissing,
            /param is missing or the value is empty: post/
          )
        end
      end

      context 'with valid params' do
        let(:params) { { post: { content: 'updated test' } } }

        it 'updates post' do
          subject
          expect(assigns[:post]).to have_attributes(
            user_id: current_user.id,
            content: 'updated test'
          )
        end

        it 'has a 302 status code' do
          subject
          expect(response.status).to eq(302)
        end

        it 'redirects to post page' do
          expect(subject).to redirect_to "/posts/#{assigns[:post].id}"
        end
      end

      context 'with invalid params' do
        let(:params) { { post: { content: '' } } }

        it 'has a 200 status code' do
          subject
          expect(response.status).to eq(200)
        end

        it 'renders edit post template' do
          subject
          expect(response).to render_template(:edit)
        end

        it 'does not update post' do
          expect { subject }.not_to change(post, :updated_at)
        end
      end
    end

    context 'as signed in user but not an owner of a post' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:post_owner) { create(:user) }
      let(:post) { create :post, user: post_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Post with 'id'=#{post.id}/
        )
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete "/posts/#{post.id}" }

    let(:post) { create :post }

    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end

    context 'as signed in user and an owner of a post' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let!(:post) { create :post, user: current_user }

      it 'deletes post' do
        expect { subject }.to change(Post, :count).by(-1)
      end

      it 'has a 302 status code' do
        subject
        expect(response.status).to eq(302)
      end

      it 'redirects to posts page' do
        expect(subject).to redirect_to '/posts'
      end
    end

    context 'as signed in user but not an owner of a post' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:post_owner) { create(:user) }
      let(:post) { create :post, user: post_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Post with 'id'=#{post.id}/
        )
      end
    end
  end
end
