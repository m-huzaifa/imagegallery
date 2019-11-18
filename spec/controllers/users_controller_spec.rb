# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  render_views

  context 'with admin user signed_in' do
    before do
      admin = create(:user, :admin_user)
      sign_in admin
    end

    describe 'GET #show' do
      it 'assign the requested role to @role' do
        get :show, params: { id: user.id }
        expect(assigns[:user]).to eq(user)
      end

      it 'render #show view' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #index' do
      it 'render the index view' do
        get :index
        expect(response).to render_template(:index)
      end
      it 'assign the user' do
        get :index
        expect(assigns[:users]).to include(user)
      end
    end
  end

  context 'with client user signed_in' do
    before do
      client = create(:user)
      sign_in client
    end

    describe 'GET #show' do
      it 'assign the requested role to @role' do
        get :show, params: { id: user.id }
        expect(assigns[:user]).to eq(user)
      end

      it 'render #show view' do
        get :show, params: { id: controller.current_user.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
