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

end
