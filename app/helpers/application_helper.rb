# frozen_string_literal: true

module ApplicationHelper
  def present(model)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end
end
