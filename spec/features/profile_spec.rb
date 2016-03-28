require 'rails_helper'

RSpec.feature "Profile", type: :feature do

  describe "as a logged in user, I can visit my profile page" do

    it "will allow a user to visit their profile page" do
      register_and_login
      click_on 'A@yahoo.com'
      expect(page).to have_content("A@yahoo.com")
    end
  end

    it "will allow a user to create a meeting, and have that meeting appear on their profile page" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_on 'Create Meeting'
      expect(page).to have_content("100 Main St. San Diego 92103")
    end


  def register_and_login
    visit "/users/sign_up"
    fill_in 'Email', with: 'A@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', '/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end
  def new_meeting
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 92103'
    fill_in 'Subject', with: 'Ruby on Rails'
  end

end #last end
