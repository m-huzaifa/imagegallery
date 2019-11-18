# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for visitors', type: :routing do
  it 'routes GET /visitors to the VisitorsController#index' do
    expect(get('/visitors')).to route_to('visitors#index')
  end
  it 'routes to visitors' do
    expect(get('/visitors')).to be_routable
  end
  it 'routes root to VisitorsController#index' do
    expect(get('/')).to route_to('visitors#index')
  end
end
