# frozen_string_literal: true

module UserHelper
  def owner?(record)
    current_user == record.user
  end
end
