# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe EmoteReactionsController, type: :request do
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
      subject { post "/posts/#{post_record.id}/emote_reactions" }

      it_behaves_like 'redirect to sign in for not signed in users'

      it 'does not create emote_reaction' do
        expect { subject }.not_to change(EmoteReaction, :count)
      end

      context 'as signed in user' do
        subject { post "/posts/#{post_record.id}/emote_reactions", params: params }

        let(:current_user) { create(:user) }

        before { sign_in current_user }

        context 'without emote_reaction params' do
          let(:params) { nil }

          it 'raises an error' do
            expect { subject }.to raise_exception(
              ActionController::ParameterMissing,
              /param is missing or the value is empty: emote_reaction/
            )
          end
        end

        context 'with valid params' do
          let(:params) { { emote_reaction: { kind: 'like' } } }

          it 'creates emote reaction' do
            expect { subject }.to change(EmoteReaction, :count).by(1)
          end

          it 'saves emote reaction to current user' do
            expect { subject }.to change { current_user.emote_reactions.count }.by(1)
          end

          it 'saves emote reaction to post' do
            expect { subject }.to change { post_record.emote_reactions.count }.by(1)
          end

          it 'saves emote reaction parameters' do
            subject
            expect(assigns[:emote_reaction]).to have_attributes(
              user_id: current_user.id,
              emotionable: post_record,
              kind: 'like'
            )
          end

          it_behaves_like 'redirect'

          it 'redirects back' do
            post "/posts/#{post_record.id}/emote_reactions",
                 params: params,
                 headers: { 'HTTP_REFERER' => post_url(post_record) }
            expect(response).to redirect_to post_url(post_record)
          end

          it 'redirects to root without referer' do
            expect(subject).to redirect_to root_url
          end
        end

        context 'with invalid params' do
          let(:params) { { emote_reaction: { kind: '' } } }

          it_behaves_like 'redirect'

          it 'redirects back' do
            post "/posts/#{post_record.id}/emote_reactions",
                 params: params,
                 headers: { 'HTTP_REFERER' => post_url(post_record) }
            expect(response).to redirect_to post_url(post_record)
          end

          it 'redirects to root without referer' do
            expect(subject).to redirect_to root_url
          end

          it 'does not create emote reaction' do
            expect { subject }.not_to change(EmoteReaction, :count)
          end
        end
      end
    end
  end
end
