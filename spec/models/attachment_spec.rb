# frozen_string_literal: true

require 'rails_helper'

describe Attachment, type: :model do
  subject { build(:attachment) }

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
    it 'belong to user' do
      is_expected.to belong_to(:user)
    end
    it 'have many reactions' do
      is_expected.to have_many(:reactions)
    end
  end

  context 'validations' do
    it 'have presence title' do
      is_expected.to validate_presence_of(:title)
    end
    it 'have presence description' do
      is_expected.to validate_presence_of(:description)
    end
    it 'have presence image_type' do
      is_expected.to validate_presence_of(:image_type)
    end
    it 'have presence place' do
      is_expected.to validate_presence_of(:place)
    end
    it 'have presence price' do
      is_expected.to validate_presence_of(:price)
    end
    it 'validates price to be integers only' do
      is_expected.to validate_numericality_of(:price)
    end
    it 'have presence created_by' do
      is_expected.to validate_presence_of(:created_by)
    end
    it 'have presence image' do
      is_expected.to validate_presence_of(:image)
    end
    it 'have presence amount' do
      is_expected.to validate_presence_of(:amount)
    end
    it 'validates amount to be integers only' do
      is_expected.to validate_numericality_of(:amount)
    end
  end

  context do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end
  end

  describe 'class methods' do
    let!(:user) { create(:user) }
    let!(:attachment) { create(:attachment) }

    context 'already_liked' do
      subject { attachment.already_liked(attachment, user) }
      it 'return true when attachment is liked' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 1)
        is_expected.to be true
      end
      it 'return false when attachment is reacted but not liked/disliked' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 0)
        is_expected.to be false
      end
    end

    context 'already_disliked' do
      subject { attachment.already_disliked(attachment, user) }
      it 'return true when attachment is disliked' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 0)
        is_expected.to be true
      end
      it 'return false when attachment is reacted but not disliked/liked' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 1)
        is_expected.to be false
      end
    end

    context 'already_reacted' do
      subject { attachment.already_reacted(attachment, user) }
      it 'return true when attachment is reacted' do
        reaction = Reaction.create(user: user, attachment: attachment, status: 1)
        is_expected.to be true
      end
      it 'return false when attachment is not reacted' do
        is_expected.to be false
      end
    end
  end
end
