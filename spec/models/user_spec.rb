# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  subject { create(:user) }

  context 'fields' do
    it 'has a username field' do
      is_expected.to respond_to(:username)
    end
    it 'has a email field' do
      is_expected.to respond_to(:email)
    end
    it 'has a password field' do
      is_expected.to respond_to(:password)
    end
  end

  context do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'associations' do
    it 'have many attachments' do
      is_expected.to have_many(:attachments)
    end
    it 'accept nested attributes for attachments' do
      is_expected.to accept_nested_attributes_for(:attachments)
    end
  end

  context 'validations' do
    it 'have presence username' do
      is_expected.to validate_presence_of(:username)
    end
  end

  describe 'class methods' do
    let(:admin) { create(:user, :admin_user) }
    let(:client) { create(:user) }

    context 'admin?' do
      it 'return true when user is admin' do
        expect(admin.admin?).to be true
      end
      it 'return false when user is not admin' do
        expect(client.admin?).to be false
      end
    end

    context 'client?' do
      it 'return true when user is client' do
        expect(client.client?).to be true
      end
      it 'return false when user is not client' do
        expect(admin.client?).to be false
      end
    end

    context 'assign_default_role' do
      it 'return true when default role is set to client' do
        client.roles.destroy_all
        client.assign_default_role
        expect(client.client?).to be true
      end
    end
  end
end
