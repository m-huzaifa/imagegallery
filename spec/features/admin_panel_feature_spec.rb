# frozen_string_literal: true

require 'rails_helper'

describe 'Admin Panel Features', type: :feature do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin_user) }

  context 'client user' do
    before do
      login_as user
    end

    it 'sees links at admin panel' do
      visit admin_root_path
      expect(page).to have_link 'Attachments'
      expect(page).to have_link 'Home'
      expect(page).to have_link 'Logout'
      expect(page).to have_link 'Dashboard'
    end

    it 'creates an attachment' do
      visit new_admin_attachment_path
      within('form') do
        fill_in 'Title', with: 'test title'
        fill_in 'Description', with: 'test title'
        fill_in 'Image type', with: 'test title'
        fill_in 'Place', with: 'test title'
        fill_in 'Created by', with: 'test title'
        fill_in 'Price', with: '100'
        fill_in 'Amount', with: '10'
        attach_file('Image', "spec/support/image.jpg")
        page.select user.username, from: 'User'
        click_button 'Create Attachment'
      end
      within('.flash_notice') do
        expect(page).to have_content 'Attachment was successfully created.'
      end
      expect(page).to have_content Attachment.last.title
      expect(page).to have_content Attachment.last.description
      expect(page).to have_content Attachment.last.image_type
      expect(page).to have_content Attachment.last.place
      expect(page).to have_content Attachment.last.created_by
      expect(page).to have_content Attachment.last.price
      expect(page).to have_content Attachment.last.amount
      expect(page).to have_content user.username
    end

    it 'sees all attachments at admin/attachments page' do
      create(:attachment)
      visit admin_attachments_path
      expect(page).to have_content Attachment.last.id
      expect(page).to have_content Attachment.last.title
      expect(page).to have_content Attachment.last.user.username
    end
  end

  context 'client user' do
    before do
      login_as admin
    end

    it 'sees links at admin panel' do
      visit admin_root_path
      expect(page).to have_link 'Attachments'
      expect(page).to have_link 'Home'
      expect(page).to have_link 'Logout'
      expect(page).to have_link 'Dashboard'
      expect(page).to have_link 'Comments'
      expect(page).to have_link 'Roles'
      expect(page).to have_link 'Users'
    end

    it 'creates an attachment' do
      visit new_admin_attachment_path
      within('form') do
        fill_in 'Title', with: 'test title'
        fill_in 'Description', with: 'test title'
        fill_in 'Image type', with: 'test title'
        fill_in 'Place', with: 'test title'
        fill_in 'Created by', with: 'test title'
        fill_in 'Price', with: '100'
        fill_in 'Amount', with: '10'
        attach_file('Image', "spec/support/image.jpg")
        page.select user.username, from: 'User'
        click_button 'Create Attachment'
      end
      within('.flash_notice') do
        expect(page).to have_content 'Attachment was successfully created.'
      end
      expect(page).to have_content Attachment.last.title
      expect(page).to have_content Attachment.last.description
      expect(page).to have_content Attachment.last.image_type
      expect(page).to have_content Attachment.last.place
      expect(page).to have_content Attachment.last.created_by
      expect(page).to have_content Attachment.last.price
      expect(page).to have_content Attachment.last.amount
      expect(page).to have_content user.username
      expect(page).to have_link 'Edit Attachment'
    end

    it 'sees all attachments at admin/attachments page' do
      create(:attachment)
      visit admin_attachments_path
      expect(page).to have_content Attachment.last.id
      expect(page).to have_content Attachment.last.title
      expect(page).to have_content Attachment.last.user.username
      expect(page).to have_link 'New Attachment'
    end

    it 'sees all roles at admin/roles page' do
      create(:role)
      visit admin_roles_path
      expect(page).to have_content Role.last.id
      expect(page).to have_content Role.last.name
      expect(page).to have_link 'New Role'
    end

    it 'creates a new role' do
      visit new_admin_role_path
      within('form') do
        fill_in 'Name', with: 'test role'
        click_button 'Create Role'
      end
      within('.flash_notice') do
        expect(page).to have_content 'Role was successfully created.'
      end
      expect(page).to have_content 'test role'
    end

    it 'sees all users at admin/users page' do
      visit admin_users_path
      expect(page).to have_content user.username
      expect(page).to have_content user.email
      expect(page).to have_content admin.username
      expect(page).to have_content admin.email
      expect(page).to have_content user.roles.name
      expect(page).to have_content admin.roles.name
      expect(page).to have_link 'New User'
    end

    it 'creates a new user' do
      visit new_admin_user_path
      within('form') do
        fill_in 'Username', with: 'test user'
        fill_in 'Email', with: 'testuser@gmail.com'
#        fill_in 'Password', with: '123456'
        fill_in 'user[password]', with: '123456' # match on name attribute
        fill_in 'Password confirmation', with: '123456'
      #  byebug
      #  page.find('li#user_password_input').set('some text')
        click_button 'Create User'
      end
#      expect(page).to have_content 'can\'t be blank'
 #     expect(page).to have_content('Password', count: 1)
# byebug
    #  within('.flash_notice') do
        expect(page).to have_content 'User was successfully created.'
    #  end
    end
  end

end
