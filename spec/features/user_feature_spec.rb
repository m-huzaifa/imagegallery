# frozen_string_literal: true

require 'rails_helper'

describe 'User Features', type: :feature do
  let!(:user) { create(:user) }

  describe 'user sign in' do
    context 'with invalid params' do
      it 'not signing in with empty email and password' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: ''
          fill_in 'Password', with: ''
        end
        click_button 'Sign in'
        within('.flash_alert') do
          expect(page).to have_content 'Invalid Email or password.'
        end
      end
      it 'not signing in with incorrect email and password' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: '12345s6'
        end
        click_button 'Sign in'
        within('.flash_alert') do
          expect(page).to have_content 'Invalid Email or password.'
        end
      end
      it 'not signing in with incorrect email' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: user.password
        end
        click_button 'Sign in'
        within('.flash_alert') do
          expect(page).to have_content 'Invalid Email or password.'
        end
      end
      it 'not signing in with incorrect password' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: '123456ds'
        end
        click_button 'Sign in'
        within('.flash_alert') do
          expect(page).to have_content 'Invalid Email or password.'
        end
      end
    end
    context 'with valid params' do
      it 'Signing in with correct credentials' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
        end
        click_button 'Sign in'
        within('.flash_notice') do
          expect(page).to have_content 'Signed in successfully.'
        end
      end
      it 'See navigation links after signed in' do
        visit '/users/sign_in'
        within('form') do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
        end
        click_button 'Sign in'
        expect(page).to have_link 'Home'
        expect(page).to have_link 'Edit account'
        expect(page).to have_link 'My Attachments'
        expect(page).to have_link 'All Attachments'
        expect(page).to have_link 'my profile'
        expect(page).to have_link 'Log out'
        expect(page).to have_link 'Admin Panel'
      end
    end
  end

  describe 'user sign up' do
    context 'with invalid params' do
      it 'not sign up with blank username' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: ''
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content 'Username can\'t be blank'
        end
      end
      it 'not sign up with blank email' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: ''
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content 'Email can\'t be blank'
        end
      end
      it 'not sign up with email has already taken' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: user.email
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content 'Email has already been taken'
        end
      end
      it 'not sign up with blank password' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: ''
          fill_in 'Password confirmation', with: '123456'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content "Password can't be blank"
        end
      end
      it 'not sign up with blank password' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: '123'
          fill_in 'Password confirmation', with: '123'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end
      end
      it 'not sign up with password confirmation not match password' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123'
        end
        click_button 'Sign up'
        within('div#error_explanation') do
          expect(page).to have_content "Password confirmation doesn't match Password"
        end
      end
    end
    context 'with valid params' do
      it 'successfully signed up' do
        visit '/users/sign_up'
        within('form') do
          fill_in 'Username', with: 'sample user'
          fill_in 'Email', with: 'sample_user@gmail.com'
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
        end
        click_button 'Sign up'
        within('.flash_notice') do
          expect(page).to have_content 'Welcome! You have signed up successfully.'
        end
      end
    end
  end

  describe 'Show User Profile' do
    it 'show username, email, edit profile link, back link' do
      login_as user
      visit user_path(user)
      expect(page).to have_content user.username
      expect(page).to have_content user.email
      expect(page).to have_link 'edit profile'
      expect(page).to have_link 'Back'
    end
  end

  describe 'Edit User Profile' do
    before do
      login_as user
    end
    context 'with invalid params' do
      it 'not update with invalid username' do
        visit edit_user_registration_path
        expect(page).to have_link 'Back'
        expect(page).to have_button 'Update'
        expect(page).to have_button 'Delete My Account'
        expect(page).to have_field 'Username'
        within('form#edit_user') do
          fill_in 'user_username', with: ''
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text("Username can't be blank")
        end
      end
      it 'not update with invalid email' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'user_email', with: ''
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text("Email can't be blank")
        end
      end
      it 'not update with already present email' do
        user = create(:user)
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Email', with: user.email
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text('Email has already been taken')
        end
      end
      it 'not update with incorrect new password' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Password', with: '123'
          fill_in 'Password confirmation', with: '123'
          fill_in 'Current password', with: user.password
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text('Password is too short (minimum is 6 characters)')
        end
      end
      it 'not update with incorrect password confirmation' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Password', with: '123456789'
          fill_in 'Password confirmation', with: '123456'
          fill_in 'Current password', with: user.password
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text("Password confirmation doesn't match Password")
        end
      end
      it 'not update with blank current password' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Password', with: '123456789'
          fill_in 'Password confirmation', with: '123456789'
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text("Current password can't be blank")
        end
      end
      it 'not update with invalid current password' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Password', with: '123456789'
          fill_in 'Password confirmation', with: '123456789'
          fill_in 'Current password', with: 'mvksdhfn'
        end
        click_button 'Update'
        within('div#error_explanation') do
          expect(page).to have_text('Current password is invalid')
        end
      end
    end
    context 'with valid params' do
      it 'updated with valid username and email' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'user_username', with: 'testing user'
          fill_in 'Email', with: 'testing@gmail.com'
        end
        click_button 'Update'
        within('.flash_notice') do
          expect(page).to have_text('Your account has been updated successfully.')
        end
      end
      it 'updated with valid new password and current password' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'Password', with: '123456789'
          fill_in 'Password confirmation', with: '123456789'
          fill_in 'Current password', with: user.password
        end
        click_button 'Update'
        within('.flash_notice') do
          expect(page).to have_text('Your account has been updated successfully.')
        end
      end
      it 'updated with valid all params' do
        visit edit_user_registration_path
        within('form#edit_user') do
          fill_in 'user_username', with: 'testing user'
          fill_in 'Email', with: 'testing@gmail.com'
          fill_in 'Password', with: '123456789'
          fill_in 'Password confirmation', with: '123456789'
          fill_in 'Current password', with: user.password
        end
        click_button 'Update'
        within('.flash_notice') do
          expect(page).to have_text('Your account has been updated successfully.')
        end
      end
    end
  end

  describe 'log out' do
    before do
      login_as user
    end
    it 'back to root path' do
      visit root_path
      logout(:user)
      #  within(".flash_notice") do
      #  expect(page).to have_content 'Signed out successfully.'
      #  end
    end
  end
end
