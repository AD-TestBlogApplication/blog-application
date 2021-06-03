# frozen_string_literal: true

module ActiveRecordErrorsHelper
  def render_record_errors(record)
    render partial: 'shared/partials/render_record_errors', locals: { record: record }
  end
end
