# frozen_string_literal: true

class PostPresenter < BasePresenter
  def created_at_about
    @view.time_ago_in_words(@model.created_at)
  end
end
