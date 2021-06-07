# frozen_string_literal: true

require 'rails_helper'

module EmoteReactions
  RSpec.describe EmoteReactionCreator do
    subject(:creator) { described_class.new(emotionable: emotionable, user: user, kind: kind) }

    let(:emotionable) { create :post }
    let(:user) { create :user }
    let(:kind) { :like }

    describe '#call' do
      subject { creator.call }

      it { is_expected.to be_a EmoteReaction }

      it 'creates new emote reaction' do
        expect { subject }.to change(EmoteReaction, :count).by(1)
      end

      it 'assigns attributes to new emote reaction' do
        expect(subject).to have_attributes(
          user: user,
          emotionable: emotionable,
          kind: kind.to_s
        )
      end

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

        context 'missing kind' do
          let(:kind) { nil }

          it 'raises an error' do
            expect { subject }.to raise_exception(
              ActiveRecord::NotNullViolation,
              /Field 'kind' doesn't have a default value/
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
    end
  end
end
