# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  subject { create(:reaction) }

  context 'fields' do
    it 'has a status field' do
      is_expected.to respond_to(:status)
    end
    it 'has a user_id field' do
      is_expected.to respond_to(:user_id)
    end
    it 'has a attachment_id field' do
      is_expected.to respond_to(:attachment_id)
    end
  end

  context 'associations' do
    it 'belong to user' do
      is_expected.to belong_to(:user)
    end
    it 'belong to attachment' do
      is_expected.to belong_to(:attachment)
    end
  end

  context 'validations' do
    it 'status be present' do
      is_expected.to validate_presence_of(:status)
    end
    it 'has enum for status' do
      is_expected.to define_enum_for(:status)
    end
    it 'unique user scoped with attachment' do
      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:attachment_id)
    end
  end

  context 'with valid params' do
    it 'is valid' do
      is_expected.to be_valid
    end
  end
end
