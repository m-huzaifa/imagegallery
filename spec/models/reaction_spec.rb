# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  before (:each) do
    @user = FactoryBot.build(:user)
    @attachment = FactoryBot.build(:attachment)
    @reaction = Reaction.create(status: 1, user: @user, attachment: @attachment)
  end

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
    it 'should belong to user' do
      is_expected.to belong_to(:user)
    end
    it 'should belong to attachment' do
      is_expected.to belong_to(:attachment)
    end
  end

  context 'validations' do
    it 'status should be present' do
      is_expected.to validate_presence_of(:status)
    end
    it 'should has enum for status' do
      is_expected.to define_enum_for(:status)
    end
    it 'user should be unique' do
      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:attachment_id)
    end
  end

  context do
    it 'is valid with valid attributes' do
      expect(@reaction).to be_valid
    end
  end
end
