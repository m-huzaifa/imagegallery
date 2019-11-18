# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for roles', type: :routing do
  it 'routes GET /roles to the roles#index' do
    expect(get('/roles')).to route_to('roles#index')
  end
  it 'routes post /roles to roles#create' do
    expect(post('/roles')).to route_to('roles#create')
  end
  it 'routes GET /roles/new to roles#new' do
    expect(get('/roles/new')).to route_to('roles#new')
  end
  it 'routes GET /roles/12/edit to roles#edit' do
    expect(get('/roles/12/edit')).to route_to('roles#edit', id: '12')
  end
  it 'routes GET /roles/12 to roles#show' do
    expect(get('/roles/12')).to route_to('roles#show', id: '12')
  end
  it 'routes put /roles/12 to roles#update' do
    expect(put('/roles/12')).to route_to('roles#update', id: '12')
  end
  it 'routes patch /roles/12 to roles#update' do
    expect(patch('/roles/12')).to route_to(controller: 'roles', action: 'update', id: '12')
  end
  it 'routes patch /roles/12 to roles#destroy' do
    expect(delete('/roles/12')).to route_to(controller: 'roles', action: 'destroy', id: '12')
  end
end
