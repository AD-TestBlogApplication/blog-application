# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveRecordErrorsHelper, type: :helper do
  describe '#render_record_errors' do
    subject { helper.render_record_errors(record) }

    let(:record) { build :user }

    it 'renders record errors partial' do
      allow(helper).to receive(:render)
      subject
      expect(helper).to have_received(:render).with(
        partial: 'shared/partials/render_record_errors',
        locals: { record: record }
      )
    end
  end
end
