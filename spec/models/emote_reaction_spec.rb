# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmoteReaction, type: :model do
  it 'has kinds enum' do
    expect(described_class.kinds).to eq('like' => 0, 'dislike' => 1)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:emotionable) }
  end

  describe 'validations' do
    subject { create :emote_reaction }

    it { is_expected.to validate_uniqueness_of(:user).scoped_to(%i[emotionable_id emotionable_type kind]) }
  end
end
