require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  describe "as a user, I can visit the login page" do
    it "will allow a user to visit the login page" do
    visit "/users/sign_in"
      expect(page).to have_content("Log in")
    end

    it "will allow a user to enter an email address, password, and login" do
      visit "/users/sign_in"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
    end
  end

  describe "as a user, I can visit the registration page" do
    it "will allow a user to visit the registration page" do
    visit "/users/sign_up"
      expect(page).to have_content("Sign up")
    end

    it "will allow a user to enter an email address, password, password confirm and register" do
      visit "/users/sign_up"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Sign up'
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    it "requires an email address" do
      visit "/users/sign_up"
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    it "requires a password" do
      visit "/users/sign_up"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Sign up'
      expect(page).to have_content("Password can't be blank")
    end

    it "requires password and password confirmation to be the same" do
      visit "/users/sign_up"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end



end
