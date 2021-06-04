# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  shared_examples 'ok response' do
    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end
  end

  shared_examples 'redirect' do
    it 'has a 302 status code' do
      subject
      expect(response.status).to eq(302)
    end
  end

  shared_examples 'redirect to sign in for not signed in users' do
    it_behaves_like 'redirect'

    it 'redirects to sign in page' do
      expect(subject).to redirect_to '/users/sign_in'
    end
  end

  shared_examples 'renders template with success status' do |template|
    it_behaves_like 'ok response'

    it "renders #{template} template" do
      subject
      expect(response).to render_template(template)
    end
  end

  describe 'GET edit' do
    subject { get "/comments/#{comment.id}/edit" }

    let(:comment) { create :comment }

    it_behaves_like 'redirect to sign in for not signed in users'

    context 'as signed in user and an owner of a comment' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:comment) { create :comment, user: current_user }

      it_behaves_like 'ok response'
    end

    context 'as signed in user but not an owner of a comment' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:comment_owner) { create(:user) }
      let(:comment) { create :comment, user: comment_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Comment with 'id'=#{comment.id}/
        )
      end
    end
  end

  describe 'PUT update' do
    subject { put "/comments/#{comment.id}" }

    let(:comment) { create :comment, commentable: commentable }
    let(:commentable) { create :post }

    it_behaves_like 'redirect to sign in for not signed in users'

    context 'as signed in user and an owner of a comment' do
      subject { put "/comments/#{comment.id}", params: params }

      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:comment) { create :comment, user: current_user, commentable: commentable }

      context 'without comment params' do
        let(:params) { nil }

        it 'raises an error' do
          expect { subject }.to raise_exception(
            ActionController::ParameterMissing,
            /param is missing or the value is empty: comment/
          )
        end
      end

      context 'with valid params' do
        let(:params) { { comment: { content: 'updated test' } } }

        it 'updates comment' do
          subject
          expect(assigns[:comment]).to have_attributes(
            user_id: current_user.id,
            commentable: commentable,
            content: 'updated test'
          )
        end

        it_behaves_like 'redirect'

        it 'redirects to commentable page' do
          expect(subject).to redirect_to "/posts/#{assigns[:comment].commentable.id}"
        end
      end

      context 'with invalid params' do
        let(:params) { { comment: { content: '' } } }

        it_behaves_like 'renders template with success status', :edit

        it 'does not update comment' do
          expect { subject }.not_to change(comment, :updated_at)
        end
      end
    end

    context 'as signed in user but not an owner of a comment' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:comment_owner) { create(:user) }
      let(:comment) { create :comment, user: comment_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Comment with 'id'=#{comment.id}/
        )
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete "/comments/#{comment.id}" }

    let(:comment) { create :comment }

    it_behaves_like 'redirect to sign in for not signed in users'

    context 'as signed in user and an owner of a comment' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let!(:comment) { create :comment, user: current_user, commentable: commentable }
      let(:commentable) { create :post }

      it 'deletes comment' do
        expect { subject }.to change(Comment, :count).by(-1)
      end

      it_behaves_like 'redirect'

      it 'redirects to commentable page' do
        expect(subject).to redirect_to commentable
      end
    end

    context 'as signed in user but not an owner of a comment' do
      before { sign_in current_user }

      let(:current_user) { create(:user) }
      let(:comment_owner) { create(:user) }
      let(:comment) { create :comment, user: comment_owner }

      it 'raises an error' do
        expect { subject }.to raise_exception(
          ActiveRecord::RecordNotFound,
          /Couldn't find Comment with 'id'=#{comment.id}/
        )
      end
    end
  end
end
