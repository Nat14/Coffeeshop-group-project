require 'rails_helper'

RSpec.feature "Profile", type: :feature, js:true do

  describe "as a logged in user, I can visit my profile page" do

    it "will allow a user to visit their profile page" do
      register_and_login
      visit "/"
      click_on 'Apple'
      expect(page).to have_content('Apple')
    end

    it "will allow a user to create a meeting, and have that meeting appear on their profile page" do
      register_and_login
      new_meeting
      click_on 'Create Meeting'
      expect(page).to have_content("100 Main St. San Diego 92103")
      click_on 'Apple'
      expect(page).to have_content("100 Main St. San Diego 92103")
    end

    it "will allow user to update profile infomration" do
      register_and_login
      new_profile
      fill_in 'user_current_password', with: 'password1'
      click_button 'Update'
      expect(page).to have_content("Your account has been updated successfully.")
      expect(page).to have_content("Hello")
    end

    it "will not allow user to update profile infomration without a password" do
      register_and_login
      new_profile
      click_button 'Update'
      expect(page).to have_content("Current password can't be blank")
    end

    it "will allow a user to see other user profile page" do
      register_and_login
      new_meeting
      click_on 'Create Meeting'
      new_profile
      fill_in 'user_current_password', with: 'password1'
      click_button 'Update'
      click_on 'Log Out'
      register_and_login2
      click_on 'meeting_list_btn'
      expect(page).to have_content("Bat")
      find(".image").click
      first(:link, 'APPLE').click
      expect(page).to have_content("Hello")
    end
  end

  def register_and_login
    visit "/users/sign_up"
    fill_in 'Username', with: 'Apple'
    fill_in 'Email', with: 'A@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def new_meeting
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 92103'
    fill_in 'Subject', with: 'Ruby on Rails'
  end

  def new_profile
    click_on 'Apple'
    click_on 'Manage Profile'
    fill_in 'About Me', with: 'Hello'
    fill_in 'Location', with: 'San Diego'
    fill_in 'Gender', with: 'Female'
    fill_in 'user_strength', with: 'Ruby'
    fill_in 'user_weakness', with: 'Rails'
    fill_in 'Interests', with: 'Coffee'
  end

  def register_and_login2
    visit "/users/sign_up"
    fill_in 'Username', with: 'Bat'
    fill_in 'Email', with: 'B@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end
end #last end
