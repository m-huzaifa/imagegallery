# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for users', type: :routing do
  context 'with UsersController' do
    it 'routes GET /users/12/new_gallery to UsersController#new_gallery' do
      expect(get('/users/12/new_gallery')).to route_to(controller: 'users', action: 'new_gallery', user_id: '12')
    end
    it 'routes GET /users to the UsersController#index' do
      expect(get('/users')).to route_to('users#index')
    end
    it 'routes to /users' do
      expect(get('/users')).to be_routable
    end
    it 'routes GET /users/new to UsersController#new' do
      expect(get('/users/new')).to route_to('users#new')
    end
    it 'routes GET /users/12/edit to UsersController#edit' do
      expect(get('/users/12/edit')).to route_to('users#edit', id: '12')
    end
    it 'routes GET /users/12 to UsersController#show' do
      expect(get('/users/12')).to route_to('users#show', id: '12')
    end
    it 'routes put /users/12 to UsersController#update' do
      expect(put('/users/12')).to route_to('users#update', id: '12')
    end
    it 'routes patch /users/12 to UsersController#create_gallery' do
      expect(patch('/users/12')).to route_to(controller: 'users', action: 'create_gallery', user_id: '12')
    end
    it 'routes patch /users/12 to UsersController#destroy' do
      expect(delete('/users/12')).to route_to(controller: 'users', action: 'destroy', id: '12')
    end
    it 'routes post /users/ to UsersController#create' do
      #  expect(post('/users')).to route_to("users#create")
    end
  end

  context 'with Devise' do
    it 'routes GET /users/sign_in to devise/sessions#new' do
      expect(get('/users/sign_in')).to route_to('devise/sessions#new')
    end
    it 'routes POST /users/sign_in to devise/sessions#create' do
      expect(post('/users/sign_in')).to route_to('devise/sessions#create')
    end
    it 'routes DELETE /users/sign_out to devise/sessions#destroy' do
      expect(delete('/users/sign_out')).to route_to('devise/sessions#destroy')
    end
    it 'routes GET /users/password/new to devise/passwords#new' do
      expect(get('/users/password/new')).to route_to('devise/passwords#new')
    end
    it 'routes GET /users/password/edit to devise/passwords#edit' do
      expect(get('/users/password/edit')).to route_to('devise/passwords#edit')
    end
    it 'routes PATCH /users/password to devise/passwords#update' do
      expect(patch('/users/password')).to route_to('devise/passwords#update')
    end
    it 'routes PUT /users/password to devise/passwords#update' do
      expect(put('/users/password')).to route_to('devise/passwords#update')
    end
    it 'routes POST /users/password to devise/passwords#create' do
      expect(post('/users/password')).to route_to('devise/passwords#create')
    end
  end

  context 'with RegistrationsController' do
    it 'routes GET /users/cancel to registrations#cancel' do
      expect(get('/users/cancel')).to route_to('registrations#cancel')
    end
    it 'routes GET /users/sign_up to registrations#new' do
      expect(get('/users/sign_up')).to route_to('registrations#new')
    end
    it 'routes GET /users/edit to registrations#edit' do
      expect(get('/users/edit')).to route_to('registrations#edit')
    end
    it 'routes PATCH /users to registrations#update' do
      expect(patch('/users')).to route_to('registrations#update')
    end
    it 'routes PUT /users to registrations#update' do
      expect(put('/users')).to route_to('registrations#update')
    end
    it 'routes DELETE /users to registrations#destroy' do
      expect(delete('/users')).to route_to('registrations#destroy')
    end
    it 'routes POST /users to registrations#create' do
      expect(post('/users')).to route_to('registrations#create')
    end
  end
end
