# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { create(:role) }

  context 'fields' do
    it 'has a name field' do
      is_expected.to respond_to(:name)
    end
  end

  context 'validations' do
    it 'name should be present' do
      is_expected.to validate_presence_of(:name)
    end
  end

  context 'associations' do
    it 'have and belongs to many users' do
      is_expected.to have_and_belong_to_many(:users)
    end
  end

  context do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end
  end
end
