require 'rails_helper'

RSpec.feature "searches", type: :feature,  js:true do

  describe "User is able to do a keyword search" do

    describe "As an internet user" do
      it "can visit the meetings page and do a keyword search over meetings" do
        new_register_and_login
        new_meeting
        click_button 'Create Meeting'
        click_on 'Log Out'
        fill_in 'landing-input', with: 'J@yahoo.com'
        click_on 'search'
        expect(page).to have_content("100 Main St. San Diego 92103")
      end

      it "can visit the meetings page and do a keyword search over users" do
        new_register_and_login
        new_meeting
        click_button 'Create Meeting'
        click_on 'Log Out'
        fill_in 'landing-input', with: 'Main'
        click_on 'search'
        expect(page).to have_content("100 Main St. San Diego 92103")
      end
    end

    def new_register_and_login
      visit "/users/sign_up"
      fill_in 'Email', with: 'J@yahoo.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      attach_file('user_avatar', '/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
      click_button 'Sign Up'
    end

    def new_meeting
      visit 'meetings/new'
      fill_in 'Address', with: '100 Main St. San Diego 92103'
      fill_in 'Subject', with: 'Ruby on Rails'
    end
 end

end
