require 'rails_helper'

RSpec.feature "MeetingPlaces", type: :feature do
  describe "As a logged in user" do
    it "can create a new meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      expect(page).to have_content 'Meeting was successfully created.'
    end
    it "can list current suggested meetings" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      expect(page).to have_content '100 Main St. San Diego 92103'
    end

    it "can list a confirmed meetings" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_button 'Create Meeting'
      expect(page).to have_content 'true'
    end

    it "can show a meeting that any user has created" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_button 'Create Meeting'
      click_on 'Back'
      click_on 'Show'
      expect(page).to have_content '100 Main St. San Diego 92103'
    end

    it "can edit a meeting that the current user created" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_button 'Create Meeting'
      click_on 'Edit'
      fill_in 'Subject', with: 'Javascript'
      click_button 'Update Meeting'
      expect(page).to have_content 'Javascript'
    end

    it "can destroy a meeeting that the current user created" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_button 'Create Meeting'
      click_on 'Back'
      click_on 'Destroy'
      expect(page).to have_content 'Meeting was successfully destroyed.'
    end

    it "can join a suggested meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'Log In'
      new_register_and_login
      click_on ''
      click_on 'Show'
      click_on 'Join'
      click_on 'Join'
      expect(page).to have_content 'b@yahoo.com'
    end

    it "user cannot join meeting that user has already joined" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      new_register_and_login
      click_on 'meeting_list_btn'
      click_on 'Show'
      click_on 'Join'
      click_on 'Join'
      click_on 'Back'
      click_on 'Show'
      expect(page).to have_content 'Joined'
    end

    it "user cannot join his own meeting but user can edit his own meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Back'
      click_on 'Show'
      expect(page).to have_no_content 'Joined'
      expect(page).to have_content 'Edit'
    end



  end

  describe "As an internet user" do
    it "can visit the meetings page" do
      register_and_login
      new_meeting
      check 'Confirm'
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on ''
      expect(page).to have_content '100 Main St. San Diego 92103'
    end
  end

  def register_and_login
    visit "/users/sign_up"
    fill_in 'Email', with: 'a@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', '/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def new_register_and_login
    visit "/users/sign_up"
    fill_in 'Email', with: 'b@yahoo.com'
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

  def login
    fill_in 'Email', with: 'a@yahoo.com'
    fill_in 'Password', with: 'password1'
    click_button 'Log In'
  end

end
