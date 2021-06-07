# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  it 'routes to #edit as GET' do
    expect(get: '/comments/comment_id/edit').to route_to(
      controller: 'comments',
      action: 'edit',
      id: 'comment_id'
    )
  end

  it 'routes to #update as PUT' do
    expect(put: '/comments/comment_id').to route_to(
      controller: 'comments',
      action: 'update',
      id: 'comment_id'
    )
  end

  it 'routes to #destroy as DELETE' do
    expect(delete: '/comments/comment_id').to route_to(
      controller: 'comments',
      action: 'destroy',
      id: 'comment_id'
    )
  end
end
