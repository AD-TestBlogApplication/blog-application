# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'root routing' do
    it 'routes to #index as GET' do
      expect(get: '/').to route_to(
        controller: 'home',
        action: 'index'
      )
    end
  end
end
