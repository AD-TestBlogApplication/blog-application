# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter do
  subject(:prsenter) { described_class.new(post, view_context) }

  let(:post) { create :post }
  let(:view_context) { instance_double ActionView::Base }

  describe '#created_at_about' do
    subject { prsenter.created_at_about }

    let(:time_ago_in_words) { 'two days ago' }

    it 'returns created at date in words' do
      expect(view_context).to receive(:time_ago_in_words).with(
        post.created_at
      ).and_return(time_ago_in_words)

      expect(subject).to be time_ago_in_words
    end
  end
end
