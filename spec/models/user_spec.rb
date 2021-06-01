# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has roles enum' do
    expect(described_class.roles).to eq('client' => 0, 'admin' => 1)
  end
end
