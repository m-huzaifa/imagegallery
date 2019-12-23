# frozen_string_literal: true

require 'rails_helper'

describe 'Attachment Features', type: :feature do
  let!(:user) { create(:user) }

  context 'with user not signed in' do
    describe 'Home Page' do
      it 'shows all user\'s gallery links' do
        create_list(:attachment, 3)
        visit root_path
        expect(page).to have_selector('img', count: 3)
        expect(page).to have_link 'Create Gallery'
        expect(page).to have_link 'Show Gallery'
      end
      it 'shows a user\'s gallery' do
        create_list(:attachment, 2, user: user)
        visit root_path
        click_link 'Show Gallery'
        expect(page).to have_selector('img', count: 2)
        expect(page).to have_link 'back'
        expect(page).to have_link 'Show'
      end
    end

    describe 'All Attachments Page' do
      it 'shows all attachments' do
        create(:attachment)
        visit all_attachments_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show'
      end
      it 'shows an attachment with ajax call on same page' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        expect(page).to have_content Attachment.last.title
        expect(page).to have_content Attachment.last.description
        expect(page).to have_content Attachment.last.image_type
        expect(page).to have_content Attachment.last.place
        expect(page).to have_content Attachment.last.created_by
        expect(page).to have_content Attachment.last.price
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
      end
      it 'user cannot like an atachment' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        click_link 'like'
        expect(page).to have_content 'You are not authorized to access this page.'
      end
    end
  end

  context 'with signed in user' do
    before do
      login_as user
    end

    describe 'Home Page' do
      it 'shows all user\'s gallery links' do
        create_list(:attachment, 3)
        visit root_path
        expect(page).to have_selector('img', count: 3)
        expect(page).to have_link 'Create Gallery'
        expect(page).to have_link 'Show Gallery'
      end
      it 'shows a user\'s gallery' do
        create_list(:attachment, 2, user: user)
        visit root_path
        click_link 'Show Gallery'
        expect(page).to have_selector('img', count: 2)
        expect(page).to have_link 'back'
        expect(page).to have_link 'Show'
      end
    end

    describe 'All Attachments Page' do
      it 'shows all attachments' do
        create(:attachment)
        visit all_attachments_path
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'Show'
      end
      it 'shows an attachment with ajax call on same page' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        expect(page).to have_content Attachment.last.title
        expect(page).to have_content Attachment.last.description
        expect(page).to have_content Attachment.last.image_type
        expect(page).to have_content Attachment.last.place
        expect(page).to have_content Attachment.last.created_by
        expect(page).to have_content Attachment.last.price
        expect(page).to have_link 'Back'
        expect(page).to have_link 'Buy'
        expect(page).to have_link 'like'
        expect(page).to have_content('likes: 0')
      end
      it 'user can like an attachment' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        click_link 'like'
        expect(page).to have_content('likes: 1')
        expect(page).to have_link 'dislike'
      end
      it 'user can dislike an attachment' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        click_link 'like'
        click_link 'dislike'
        expect(page).to have_content('likes: 0')
        expect(page).to have_link 'like'
      end
      it 'shows buy form on same page with ajax call' do
        create(:attachment)
        visit all_attachments_path
        click_link 'Show'
        click_link 'Buy'
        expect(page).to have_content 'Order form'
        within('form') do
          expect(page).to have_selector('input', count: 3)
        end
      end
    end

    describe 'Attachments Index' do
      it 'creates attachments with valid params' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
        end
        expect(page).to have_content 'Attachments was successfully updated.'
        within("div#user-attachments") do
          expect(page).to have_selector('img', count: 1)
          expect(page).to have_content Attachment.last.title
          expect(page).to have_content Attachment.last.amount
        end
      end
      it 'does not creates attachments with invalid params' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: ''
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: ''
          fill_in 'Price', with: 'mnvkdsbj'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
        end
        expect(page).to have_content 'Attachments could not be added.'
        within("div#user-attachments") do
          expect(page).to have_selector('img', count: 0)
        end
      end
      it 'creates nested attachments with valid params' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_link 'Add new Attachment'
          fill_in 'Title', with: 'test title 2'
          fill_in 'Description', with: 'test title 2'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
      #    click_button 'Submit'
        end
        expect(page).to have_content('Title', count: 2)
      #  expect(page).to have_content 'Attachments was successfully updated.'
      #  expect(page).to have_content 'Total Attachments: 2'
      #  within("div#user-attachments") do
        #  expect(page).to have_selector('img', count: 2)
      #  end
      end
      it 'shows user gallery' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
        end
        click_link 'Show Gallery'
        expect(page).to have_selector('img', count: 1)
        expect(page).to have_link 'back'
        expect(page).to have_content 'Gallery'
      end
      it 'attachment show page' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
        end
        click_link 'Show'
        expect(page).to have_current_path(attachment_path(Attachment.last))
      end
      it 'attachment edit page' do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
        end
        click_link 'Edit'
        expect(page).to have_current_path(edit_attachment_path(Attachment.last))
      end
      it 'edit attachment successfully' do
        create(:attachment, user: user)
        visit attachments_path
        click_link 'Edit'
        within('form') do
          fill_in 'Title', with: 'change title'
          fill_in 'Place', with: 'change place'
          fill_in 'Price', with: '10000'
        end
        click_button 'Update Attachment'
        within('.flash_notice') do
          expect(page).to have_content 'Attachment was successfully updated.'
        end
        expect(page).to have_current_path(attachment_path(Attachment.last))
        within('.container') do
          expect(page).to have_content 'change title'
          expect(page).to have_content 'change place'
          expect(page).to have_content '10000'
        end
      end

      it 'delete an attachment', js: true do
        visit attachments_path
        within(".nested-form") do
          fill_in 'Title', with: 'test title'
          fill_in 'Description', with: 'test title'
          fill_in 'Image type', with: 'test title'
          fill_in 'Place', with: 'test title'
          fill_in 'Created by', with: 'test title'
          fill_in 'Price', with: '100'
          fill_in 'Amount', with: '10'
          attach_file('Image', "spec/support/image.jpg")
          click_button 'Submit'
          byebug
        end
  #      page.evaluate_script('window.confirm = function() { return true; }')
    #    page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'Attachments was successfully updated.'
          expect(page).to have_link 'destroy'
        accept_confirm do
          click_link 'Destroy'
        end
      #  click_link 'Destroy'
#        expect(page).to have_current_path(edit_attachment_path(Attachment.last))
      end
    end
  end
end
