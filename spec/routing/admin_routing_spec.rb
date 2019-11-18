# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Section', type: :routing do
  it 'routes GET /admin to admin/dashboard#index' do
    expect(get('/admin')).to route_to('admin/dashboard#index')
  end

  context 'AttachmentsController' do
    it 'routes POST /admin/attachments/batch_action to admin/attachments#batch_action' do
      expect(post('/admin/attachments/batch_action')).to route_to('admin/attachments#batch_action')
    end
    it 'routes GET /admin/attachments to admin/attachments#index' do
      expect(get('/admin/attachments')).to route_to('admin/attachments#index')
    end
    it 'routes POST /admin/attachments to admin/attachments#create' do
      expect(post('/admin/attachments')).to route_to('admin/attachments#create')
    end
    it 'routes GET /admin/attachments/new to admin/attachments#new' do
      expect(get('/admin/attachments/new')).to route_to('admin/attachments#new')
    end
    it 'routes GET /admin/attachments/:id/edit to admin/attachments#edit' do
      expect(get('/admin/attachments/:id/edit')).to route_to('admin/attachments#edit', id: ':id')
    end
    it 'routes GET /admin/attachments/:id to admin/attachments#show' do
      expect(get('/admin/attachments/:id')).to route_to('admin/attachments#show', id: ':id')
    end
    it 'routes PATCH /admin/attachments/:id to admin/attachments#update' do
      expect(patch('/admin/attachments/:id')).to route_to('admin/attachments#update', id: ':id')
    end
    it 'routes PUT /admin/attachments/:id to admin/attachments#update' do
      expect(put('/admin/attachments/:id')).to route_to('admin/attachments#update', id: ':id')
    end
    it 'routes DELETE /admin/attachments/:id to admin/attachments#destroy' do
      expect(delete('/admin/attachments/:id')).to route_to('admin/attachments#destroy', id: ':id')
    end
  end

  it 'routes GET /admin/dashboard to admin/dashboard#index' do
    expect(get('/admin/dashboard')).to route_to('admin/dashboard#index')
  end

  context 'RolesController' do
    it 'routes POST /admin/roles/batch_action to admin/roles#batch_action' do
      expect(post('/admin/roles/batch_action')).to route_to('admin/roles#batch_action')
    end
    it 'routes GET /admin/roles to admin/roles#index' do
      expect(get('/admin/roles')).to route_to('admin/roles#index')
    end
    it 'routes POST /admin/roles to admin/roles#create' do
      expect(post('/admin/roles')).to route_to('admin/roles#create')
    end
    it 'routes GET /admin/roles/new to admin/roles#new' do
      expect(get('/admin/roles/new')).to route_to('admin/roles#new')
    end
    it 'routes GET /admin/roles/:id/edit to admin/roles#edit' do
      expect(get('/admin/roles/:id/edit')).to route_to('admin/roles#edit', id: ':id')
    end
    it 'routes GET /admin/roles/:id to admin/roles#show' do
      expect(get('/admin/roles/:id')).to route_to('admin/roles#show', id: ':id')
    end
    it 'routes PATCH /admin/roles/:id to admin/roles#update' do
      expect(patch('/admin/roles/:id')).to route_to('admin/roles#update', id: ':id')
    end
    it 'routes PUT /admin/roles/:id to admin/roles#update' do
      expect(put('/admin/roles/:id')).to route_to('admin/roles#update', id: ':id')
    end
  end

  context 'UsersController' do
    it 'routes POST /admin/users/batch_action to admin/users#batch_action' do
      expect(post('/admin/users/batch_action')).to route_to('admin/users#batch_action')
    end
    it 'routes GET /admin/users to admin/users#index' do
      expect(get('/admin/users')).to route_to('admin/users#index')
    end
    it 'routes POST /admin/users to admin/users#create' do
      expect(post('/admin/users')).to route_to('admin/users#create')
    end
    it 'routes GET /admin/users/new to admin/users#new' do
      expect(get('/admin/users/new')).to route_to('admin/users#new')
    end
    it 'routes GET /admin/users/:id/edit to admin/users#edit' do
      expect(get('/admin/users/:id/edit')).to route_to('admin/users#edit', id: ':id')
    end
    it 'routes GET /admin/users/:id to admin/users#show' do
      expect(get('/admin/users/:id')).to route_to('admin/users#show', id: ':id')
    end
    it 'routes PATCH /admin/users/:id to admin/users#update' do
      expect(patch('/admin/users/:id')).to route_to('admin/users#update', id: ':id')
    end
    it 'routes PUT /admin/users/:id to admin/users#update' do
      expect(put('/admin/users/:id')).to route_to('admin/users#update', id: ':id')
    end
    it 'routes DELETE /admin/users/:id to admin/users#destroy' do
      expect(delete('/admin/users/:id')).to route_to('admin/users#destroy', id: ':id')
    end
  end

  context 'AttachmentsController' do
    it 'routes GET /admin/comments to admin/comments#index' do
      expect(get('/admin/comments')).to route_to('admin/comments#index')
    end
    it 'routes POST /admin/comments to admin/comments#create' do
      expect(post('/admin/comments')).to route_to('admin/comments#create')
    end
    it 'routes GET /admin/comments/:id to admin/comments#show' do
      expect(get('/admin/comments/:id')).to route_to('admin/comments#show', id: ':id')
    end
    it 'routes DELETE /admin/comments/:id to admin/comments#destroy' do
      expect(delete('/admin/comments/:id')).to route_to('admin/comments#destroy', id: ':id')
    end
  end
end
