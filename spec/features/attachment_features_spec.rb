# frozen_string_literal: true

require 'rails_helper'

describe 'Attachment Features', type: :feature do
  let!(:user) { create(:user) }

  context 'with user not signed in' do
    describe 'Home Page' do
      it 'shows all user\'s gallery link' do
        visit root_path
        expect(page).to have_link 'Create Gallery'
        expect(page).to have_selector('img', count: 0)
        create(:attachment)
        create(:attachment)
        visit root_path
        expect(page).to have_selector('img', count: 2)
        create(:attachment, user: user)
        create(:attachment, user: user)
        visit root_path
        expect(page).to have_selector('img', count: 3)
        create :attachment
        visit root_path
        expect(page).to have_selector('img', count: 4)
      end
      it 'shows a user gallery images' do
        visit root_path
        expect(page).to have_link 'Create Gallery'
        expect(page).to have_selector('img', count: 0)
        a1 = create(:attachment, user: user)
        visit root_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show Gallery'
        click_link 'Show Gallery'
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'back'
        expect(page).to have_content 'Gallery'
        click_link 'back'
        expect(page).to have_link 'Create Gallery'
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show Gallery'
        click_link 'Show Gallery'
        expect(page).to have_link 'Show'
        click_link 'Show'
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
        expect(page).to have_content a1.title
        expect(page).to have_content a1.description
        expect(page).to have_content a1.image_type
        expect(page).to have_content a1.place
        expect(page).to have_content a1.created_by
        expect(page).to have_content a1.price
        click_link 'like'
        expect(page).to have_content 'You are not authorized to access this page.'
      end
    end

    describe 'All Attachments Page' do
      it 'shows all atachments' do
        visit all_attachments_path
        expect(page).to have_selector('img', count: 0)
        a1 = create(:attachment)
        visit all_attachments_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show'
        click_link 'Show'
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
        expect(page).to have_content a1.title
        expect(page).to have_content a1.description
        expect(page).to have_content a1.image_type
        expect(page).to have_content a1.place
        expect(page).to have_content a1.created_by
        expect(page).to have_content a1.price
      end
      it 'does not allow to like an atachment' do
        visit all_attachments_path
        expect(page).to have_selector('img', count: 0)
        a1 = create(:attachment)
        visit all_attachments_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show'
        click_link 'Show'
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
        expect(page).to have_content a1.title
        expect(page).to have_content a1.description
        expect(page).to have_content a1.image_type
        expect(page).to have_content a1.place
        expect(page).to have_content a1.created_by
        expect(page).to have_content a1.price
        click_link 'like'
        expect(page).to have_content 'You are not authorized to access this page.'
      end
    end
  end
  context 'with signed in user' do
    before do
      login_as user
    end
    describe 'All Attachments Page' do
      it 'shows an attachment and user can like and dislike the attachment' do
        visit all_attachments_path
        expect(page).to have_selector('img', count: 0)
        a1 = create(:attachment)
        visit all_attachments_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show'
        click_link 'Show'
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
        expect(page).to have_content a1.title
        expect(page).to have_content a1.description
        expect(page).to have_content a1.image_type
        expect(page).to have_content a1.place
        expect(page).to have_content a1.created_by
        expect(page).to have_content a1.price
        click_link('like')
        expect(page).to have_content('likes: 1')
        expect(page).to have_link 'dislike'
        click_link('dislike')
        expect(page).to have_content('likes: 0')
        expect(page).not_to have_content 'Order form'
        click_link 'Buy'
        expect(page).to have_content 'Order form'
        within('form') do
          expect(page).to have_selector('input', count: 3)
        end
      end
    end
  end
end
