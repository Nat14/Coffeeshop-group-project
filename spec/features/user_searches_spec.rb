require 'rails_helper'

RSpec.feature "user_searches", type: :feature, js:true do
  describe "A logged in user has saved searches" do
    it "can do a search on the main page and the search keyword is saved" do
      register_and_login1
      new_meeting
      click_on "Log Out"
      register_and_login2
      visit "/"
      fill_in 'landing-input', with: 'Ruby'
      find('#landing-input').native.send_keys(:return)
      visit "/"
      click_on "b@yahoo.com"
      expect(page).to have_content("Ruby")
    end

    it "can do a search on the profile page and the search keyword is saved" do
      register_and_login1
      new_meeting
      click_on "Log Out"
      register_and_login2
      click_on "b@yahoo.com"
      fill_in 'profile_search', with: 'Ruby'
      find('#profile_search').native.send_keys(:return)
      visit "/"
      click_on "b@yahoo.com"
      expect(page).to have_content("Ruby")
    end
  end

  def register_and_login1
    visit "/users/sign_up"
    fill_in 'Email', with: 'a@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def register_and_login2
    visit "/users/sign_up"
    fill_in 'Email', with: 'b@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')

    click_button 'Sign Up'
  end

  def new_meeting
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 92103'
    fill_in 'Subject', with: 'Ruby on Rails'
    click_on "Create Meeting"
  end

  def search_keyword
    visit "/"
    fill_in 'landing-input', with: 'Ruby'
  end
end
