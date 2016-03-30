require 'rails_helper'

RSpec.feature "LogIns", type: :feature do

  describe "as a user, I can visit the registration page" do
    it "will allow a user to visit the registration page" do
    visit "/users/sign_up"
      expect(page).to have_content("Sign Up")
    end

    it "will allow a user to enter a username, email address, password, password confirm, upload an avatar and register" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    it "requires a username" do
      visit "/users/sign_up"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      expect(page).to have_content("Username can't be blank")
    end

    it "requires an email address" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      expect(page).to have_content("Email can't be blank")
    end

    it "requires an avatar" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Sign Up'
      expect(page).to have_content("Avatar can't be blank")
    end

    it "requires a password" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password confirmation', with: 'password123'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      expect(page).to have_content("Password can't be blank")
    end

    it "requires password and password confirmation to be the same" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  describe "as a registered user, I can visit the login page" do
    it "will allow a user to visit the login page" do
    visit "/users/sign_in"
      expect(page).to have_content("Log In")
    end

    it "will allow a user to enter an email address, password, and login" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'A@yahoo.com'
      fill_in 'Password', with: 'password1'
      fill_in 'Password confirmation', with: 'password1'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      click_on 'Log Out'
      visit "/users/sign_in"
      fill_in 'Email', with: 'A@yahoo.com'
      fill_in 'Password', with: 'password1'
      click_button 'Log In'
      expect(page).to have_content("Signed in successfully")
    end

    it "requires an email address" do
      visit "/users/sign_in"
      fill_in 'Password', with: 'password123'
      click_button 'Log In'
      expect(page).to have_content("Invalid email or password")
    end

    it "requires a password" do
      visit "/users/sign_in"
      fill_in 'Email', with: 'A@yahoo.com'
      click_button 'Log In'
      expect(page).to have_content("Invalid email or password")
    end
  end

  describe "as a logged in user, I can log out" do
    it "will allow a logged in user to log out" do
      visit "/users/sign_up"
      fill_in 'Username', with: 'J'
      fill_in 'Email', with: 'A@yahoo.com'
      fill_in 'Password', with: 'password1'
      fill_in 'Password confirmation', with: 'password1'
      attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
      click_on 'Log Out'
      expect(page).to have_content("Signed out successfully")

    end
  end



end
