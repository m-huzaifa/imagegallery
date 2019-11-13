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
    it 'should have many attachments' do
      is_expected.to have_many(:attachments)
    end
    it 'should accept nested attributes for attachments' do
      is_expected.to accept_nested_attributes_for(:attachments)
    end
  end

  context 'validations' do
    it 'should have presence username' do
      is_expected.to validate_presence_of(:username)
    end
  end
end
