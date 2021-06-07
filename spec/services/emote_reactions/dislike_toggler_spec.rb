# frozen_string_literal: true

require 'rails_helper'

module EmoteReactions
  RSpec.describe DislikeToggler do
    subject(:toggler) { described_class.new(emotionable: emotionable, user: user) }

    let(:emotionable) { create :post }
    let(:user) { create :user }

    describe '#call' do
      subject { toggler.call }

      context 'with invalid params' do
        context 'missing user' do
          let(:user) { nil }

          it 'raises an error' do
            expect { subject }.to raise_exception(
              ActiveRecord::RecordInvalid,
              /Validation failed: User must exist/
            )
          end
        end

        context 'missing emotionable' do
          let(:emotionable) { nil }

          it 'raises an error' do
            expect { subject }.to raise_exception(
              NoMethodError,
              /undefined method `emote_reactions'/
            )
          end
        end
      end

      context 'dislike already exists' do
        let!(:existed_dislike) { create :emote_reaction, user: user, emotionable: emotionable, kind: :dislike }

        it 'deletes existed emote reaction' do
          expect(EmoteReaction.exists?(id: existed_dislike.id)).to be true
          expect { subject }.to change(EmoteReaction, :count).by(-1)
          expect(EmoteReaction.exists?(id: existed_dislike.id)).to be false
        end

        it 'returns deleted emote reaction' do
          deleted_record = subject
          expect(deleted_record).to be_a EmoteReaction
          expect(deleted_record).to eq existed_dislike
        end
      end

      it { is_expected.to be_a EmoteReaction }

      it 'creates new emote reaction' do
        expect { subject }.to change(EmoteReaction, :count).by(1)
      end

      it 'assigns attributes to new emote reaction' do
        expect(subject).to have_attributes(
          user: user,
          emotionable: emotionable,
          kind: 'dislike'
        )
      end

      context 'with existed like' do
        let!(:existed_like) { create :emote_reaction, user: user, emotionable: emotionable, kind: :like }

        it 'creates new emote reaction' do
          expect { subject }.to change { EmoteReaction.dislike.count }.by(1)
        end

        it 'deletes existed like' do
          expect(EmoteReaction.exists?(id: existed_like.id)).to be true
          expect { subject }.to change { EmoteReaction.like.count }.by(-1)
          expect(EmoteReaction.exists?(id: existed_like.id)).to be false
        end
      end
    end
  end
end
