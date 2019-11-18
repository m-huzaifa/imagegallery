# frozen_string_literal: true

require 'rails_helper'

describe RolesController, type: :controller do
  before do
    admin = create(:user, :admin_user)
    sign_in admin
  end
  let!(:valid_attributes) { attributes_for :role }
  let!(:invalid_attributes) { { name: '' } }
  let!(:role) { create(:role) }

  describe 'GET #show' do
    it 'assign the requested role to @role' do
      get :show, params: { id: role.id }
      expect(assigns[:role]).to eq(role)
    end
    it 'render #show view' do
      get :show, params: { id: role.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    it 'render the index view' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'assign the role' do
      get :index
      expect(assigns[:roles]).to include(role)
    end
  end

  describe 'GET #edit' do
    it 'assignd the required role' do
      get :edit, params: { id: role.id }
      expect(assigns(:role)).to eq(role)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { role: valid_attributes } }

      it 'creates a new role' do
        expect { subject }.to change { Role.count }.by(1)
      end
      it 'redirects to the new role' do
        subject
        expect(response).to redirect_to Role.last
      end
    end

    context 'with invalid params' do
      subject { post :create, params: { role: invalid_attributes } }

      it 'not create new role' do
        subject
        expect { response }.not_to change { Role.count }
      end
      it 'not create new role' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      subject { put :update, params: { id: role.id, role: valid_attributes } }

      it 'update the role' do
        subject
        expect(assigns(:role)).to eq(role)
      end
      it 'redirects to updated role' do
        subject
        expect(response).to redirect_to(@role)
      end
      it "changes role's attributes" do
        subject
        role.reload
        expect(role.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      subject { put :update, params: { id: role.id, role: invalid_attributes } }

      it 're-renders the edit method' do
        subject
        expect(response).to render_template :edit
      end
      it "does not changes @role's attributes" do
        subject
        role.reload
        expect(role.name).not_to eq(invalid_attributes[:name])
      end
    end
  end

  describe 'DELETE #Destroy' do
    subject { delete :destroy, params: { id: role.id } }

    it 'delete the role' do
      expect { subject }.to change(Role, :count).by(-1)
    end
    it 'redirects to roles #index' do
      subject
      expect(response).to redirect_to roles_url
    end
  end
end
