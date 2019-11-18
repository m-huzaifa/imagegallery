# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for orders', type: :routing do
  it 'routes GET /orders to the orders#index' do
    expect(get('/orders')).to route_to('orders#index')
  end
  it 'routes post /orders to orders#create' do
    expect(post('/orders')).to route_to('orders#create')
  end
  it 'routes GET /orders/new to orders#new' do
    expect(get('/orders/new')).to route_to('orders#new')
  end
  it 'routes GET /orders/12/edit to orders#edit' do
    expect(get('/orders/12/edit')).to route_to('orders#edit', id: '12')
  end
  it 'routes GET /orders/12 to orders#show' do
    expect(get('/orders/12')).to route_to('orders#show', id: '12')
  end
  it 'routes put /orders/12 to orders#update' do
    expect(put('/orders/12')).to route_to('orders#update', id: '12')
  end
  it 'routes patch /orders/12 to orders#update' do
    expect(patch('/orders/12')).to route_to(controller: 'orders', action: 'update', id: '12')
  end
  it 'routes patch /orders/12 to orders#destroy' do
    expect(delete('/orders/12')).to route_to(controller: 'orders', action: 'destroy', id: '12')
  end
end
