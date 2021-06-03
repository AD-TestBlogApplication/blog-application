# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has roles enum' do
    expect(described_class.roles).to eq('client' => 0, 'admin' => 1)
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
  end
end
