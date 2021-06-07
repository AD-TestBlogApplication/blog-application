# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  it 'routes to #index as GET' do
    expect(get: '/posts').to route_to(
      controller: 'posts',
      action: 'index'
    )
  end

  it 'routes to #new as GET' do
    expect(get: '/posts/new').to route_to(
      controller: 'posts',
      action: 'new'
    )
  end

  it 'routes to #create as POST' do
    expect(post: '/posts').to route_to(
      controller: 'posts',
      action: 'create'
    )
  end

  it 'routes to #edit as GET' do
    expect(get: '/posts/post_id/edit').to route_to(
      controller: 'posts',
      action: 'edit',
      id: 'post_id'
    )
  end

  it 'routes to #update as PUT' do
    expect(put: '/posts/post_id').to route_to(
      controller: 'posts',
      action: 'update',
      id: 'post_id'
    )
  end

  it 'routes to #destroy as DELETE' do
    expect(delete: '/posts/post_id').to route_to(
      controller: 'posts',
      action: 'destroy',
      id: 'post_id'
    )
  end
end
