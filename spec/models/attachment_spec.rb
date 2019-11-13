# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  context 'fields' do
    it 'has a title field' do
      is_expected.to respond_to(:title)
    end
    it 'has a description field' do
      is_expected.to respond_to(:description)
    end
    it 'has a image_type field' do
      is_expected.to respond_to(:image_type)
    end
    it 'has a place field' do
      is_expected.to respond_to(:place)
    end
    it 'has a price field' do
      is_expected.to respond_to(:price)
    end
    it 'has a created_by field' do
      is_expected.to respond_to(:created_by)
    end
    it 'has a amount field' do
      is_expected.to respond_to(:amount)
    end
    it 'has a image field' do
      is_expected.to respond_to(:image)
    end
    it 'has a user_id field' do
      is_expected.to respond_to(:user_id)
    end
  end

  context 'associations' do
    it 'should belong to user' do
      is_expected.to belong_to(:user)
    end
    it 'should have many reactions' do
      is_expected.to have_many(:reactions)
    end
  end

  context 'validations' do
    it 'should have presence title' do
      is_expected.to validate_presence_of(:title)
    end
    it 'should have presence description' do
      is_expected.to validate_presence_of(:description)
    end
    it 'should have presence image_type' do
      is_expected.to validate_presence_of(:image_type)
    end
    it 'should have presence place' do
      is_expected.to validate_presence_of(:place)
    end
    it 'should have presence price' do
      is_expected.to validate_presence_of(:price)
    end
    it 'should validates price to be integers only' do
      is_expected.to validate_numericality_of(:price)
    end
    it 'should have presence created_by' do
      is_expected.to validate_presence_of(:created_by)
    end
    it 'should have presence image' do
      is_expected.to validate_presence_of(:image)
    end
    it 'should have presence amount' do
      is_expected.to validate_presence_of(:amount)
    end
    it 'should validates amount to be integers only' do
      is_expected.to validate_numericality_of(:amount)
    end
  end
end
