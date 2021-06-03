# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ColorHelper, type: :helper do
  shared_examples 'color method' do |color_name|
    context "for #{color_name} color" do
      subject { helper.method("#{color_name}_color").call }

      it { is_expected.to eq color_name }
    end
  end

  described_class::COLORS.each do |color|
    it_behaves_like 'color method', color
  end
end
