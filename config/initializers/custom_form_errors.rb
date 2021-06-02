# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, _instance_tag|
  # gets rid of field_with_errors div being applied to fields
  html_tag
end
