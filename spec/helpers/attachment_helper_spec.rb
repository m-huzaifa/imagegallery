# frozen_string_literal: true

require 'rails_helper'

describe AttachmentsHelper, type: :helper do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = create(:user)
    #  sign_in user
  end
  describe ' check for user like' do
    it 'return true if attachment is already liked' do
      #    attachment = create(:attachment)
      #     byebug
      #   user = create(:user)
      #   reaction = Reaction.create(user: user, attachment: attachment, status: 1)
      #   r = check_for_user_like(attachment)
      #   expect(r).to be true
    end
    it 'show image url for galley view' do
      user = create(:user)
      attachment = create(:attachment, user: user)
      result_url = user.attachments.last.image.large_thumb.url
      required_url = show_gallery_image(user)
      expect(result_url).to eq(required_url)
    end
  end
end
