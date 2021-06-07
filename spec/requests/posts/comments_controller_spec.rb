# frozen_string_literal: true

require 'rails_helper'

module Posts
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

    let(:post_record) { create :post }

    describe 'POST create' do
      subject { post "/posts/#{post_record.id}/comments" }

      it_behaves_like 'redirect to sign in for not signed in users'

      it 'does not create comment' do
        expect { subject }.not_to change(Comment, :count)
      end

      context 'as signed in user' do
        subject { post "/posts/#{post_record.id}/comments", params: params }

        let(:current_user) { create(:user) }

        before { sign_in current_user }

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
          let(:params) { { comment: { content: 'test' } } }

          it 'creates comment' do
            expect { subject }.to change(Comment, :count).by(1)
          end

          it 'saves comment to current user' do
            expect { subject }.to change { current_user.comments.count }.by(1)
          end

          it 'saves comment to post' do
            expect { subject }.to change { post_record.comments.count }.by(1)
          end

          it 'saves comment parameters' do
            subject
            expect(assigns[:comment]).to have_attributes(
              user_id: current_user.id,
              commentable: post_record,
              content: 'test'
            )
          end

          it_behaves_like 'redirect'

          it 'redirects to commentable page' do
            expect(subject).to redirect_to "/posts/#{assigns[:comment].commentable.id}"
          end
        end

        context 'with invalid params' do
          let(:params) { { comment: { content: '' } } }

          it_behaves_like 'redirect'

          it 'redirects to commentable page' do
            expect(subject).to redirect_to "/posts/#{assigns[:comment].commentable.id}"
          end

          it 'does not create comment' do
            expect { subject }.not_to change(Comment, :count)
          end
        end
      end
    end
  end
end
