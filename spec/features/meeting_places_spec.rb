require 'rails_helper'

RSpec.feature "MeetingPlaces", type: :feature, js:true do
  describe "As a logged in user" do
    it "can create a new meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      expect(page).to have_content 'Meeting was successfully created.'
    end

    it "can create a new meeting and upload an image" do
      register_and_login
      new_meeting
      attach_file('meeting_image', Rails.root + 'spec/Images/coffeecup.jpeg')
      click_button 'Create Meeting'
      expect(page).to have_content 'Meeting was successfully created.'
    end

    it "can list current suggested meetings" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      expect(page).to have_content '100 Main St. San Diego 90000'
    end

    it "can list a confirmed meetings" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      fill_in 'Description', with: 'I will be there too and bring pizza.'
      click_on 'Join'
      click_on 'Meeting List'
      expect(page).to have_content '100 Main St. San Diego 90000'
    end

    it "can show a meeting that any user has created" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Meeting List'
      find(".image").click
      expect(page).to have_content '100 Main St. San Diego 90000'
    end

    it "can edit a meeting that the current user created" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Edit'
      fill_in 'Subject', with: 'Javascript'
      click_button 'Update Meeting'
      expect(page).to have_content 'Javascript'
    end
    # Test is being skipped due to capybara unable to locate the module
    skip "can destroy a meeeting that the current user created" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'A'
      click_on 'Destroy'
      click_button 'OK'
      expect(page).to have_content 'Meeting was successfully destroyed.'
    end

    it "can join a suggested meeting and put in a post message for join" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'Log In'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      fill_in 'Description', with: 'I will be there too and bring pizza.'
      click_on 'Join'
      expect(page).to have_content 'I will be there too and bring pizza.'
      click_on 'Meeting List'
      expect(page).to have_content 'Ruby on Rails'
    end

    it "can join a suggested meeting and edit a post message for join" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'Log In'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      fill_in 'Description', with: 'I will be there too and bring pizza.'
      click_on 'Join'
      click_on 'Edit'
      fill_in 'Description', with: 'I will be there too but will not bring pizza.'
      click_on 'Edit Reply'
      expect(page).to have_content 'I will be there too but will not bring pizza.'
      click_on 'Meeting List'
      expect(page).to have_content 'Ruby on Rails'
    end

    it "user can see all atendees and number of attendees" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'Log In'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      click_on 'Join'
      click_on 'Log Out'
      click_on 'Log In'
      new2_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      click_on 'Join'
      click_on 'Meeting List'
      expect(page).to have_content '3'
      find(".image").click
      expect(page).to have_content 'B'
      expect(page).to have_content 'C'
    end

    it "user cannot join meeting that user has already joined" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      click_on 'Join'
      click_on 'Meeting List'
      find(".image").click
      expect(page).to have_content 'Unjoin'
    end

    it "user cannot join his own meeting but user can edit his own meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Meeting List'
      find(".image").click
      expect(page).to have_no_content 'Joined'
      expect(page).to have_content 'Edit'
    end

    it "user can unjoin a previously joined meeting" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'Log In'
      new_register_and_login
      click_on 'meeting_list_btn'
      find(".image").click
      click_on 'Join'
      click_on 'Join'
      click_on 'Meeting List'
      find(".image").click
      click_on 'Unjoin'
      click_on 'Unjoin'
      expect(page).to have_content 'Sorry I will not be able to attend...'
    end

  end

  describe "As an internet user" do
    it "can visit the meetings page" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'meeting_list_btn'
      expect(page).to have_content '100 Main St. San Diego 90000'
    end

    it "can see meetings happening today and this week" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'meeting_list_btn'
      click_on 'Today'
      expect(page).to have_content '100 Main St. San Diego 90000'
      click_on 'Tomorrow'
      expect(page).not_to have_content '100 Main St. San Diego 90000'
      click_on 'This Week'
      expect(page).to have_content '100 Main St. San Diego 90000'
    end

    it "can see meetings happening tomorrow" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      new_meeting_tomorrow
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'meeting_list_btn'
      click_on 'Today'
      expect(page).not_to have_content 'Javascript'
      click_on 'Tomorrow'
      expect(page).to have_content 'Javascript'
    end

    it "can see meetings happening this month" do
      register_and_login
      new_meeting
      click_button 'Create Meeting'
      new_meeting_this_month
      click_button 'Create Meeting'
      click_on 'Log Out'
      click_on 'meeting_list_btn'
      click_on 'Today'
      expect(page).not_to have_content 'HTML'
      click_on 'This Week'
      expect(page).not_to have_content 'HTML'
      click_on 'This Month'
      expect(page).to have_content 'HTML'
    end
  end

  def register_and_login
    visit "/users/sign_up"
    fill_in 'Username', with: 'A'
    fill_in 'Email', with: 'a@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def new_register_and_login
    visit "/users/sign_up"
    fill_in 'Username', with: 'B'
    fill_in 'Email', with: 'b@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def new2_register_and_login
    visit "/users/sign_up"
    fill_in 'Username', with: 'C'
    fill_in 'Email', with: 'c@yahoo.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    attach_file('user_avatar', Rails.root + 'spec/Images/coffeecup.jpeg')
    click_button 'Sign Up'
  end

  def new_meeting
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 90000'
    fill_in 'Subject', with: 'Ruby on Rails'
    fill_in 'meeting_description', with: 'I will bring donuts'
    fill_in 'datepicker', with: Date.today.strftime("%b-%d-%Y")
  end

  def new_meeting_tomorrow
    visit '/meetings/new'
    fill_in 'Address', with: '200 Main St. San Diego 90000'
    fill_in 'Subject', with: 'Javascript'
    fill_in 'meeting_description', with: 'I will bring roses'
    fill_in 'datepicker', with: (Date.today + 1).strftime("%b-%d-%Y")
  end

  def new_meeting_this_month
    visit '/meetings/new'
    fill_in 'Address', with: '300 Main St. San Diego 90000'
    fill_in 'Subject', with: 'HTML'
    fill_in 'meeting_description', with: 'I will bring a cup of coffee'
    fill_in 'datepicker', with: (Date.today + 20).strftime("%b-%d-%Y")
  end

  def login
    fill_in 'Email', with: 'a@yahoo.com'
    fill_in 'Password', with: 'password1'
    click_button 'Log In'
  end

end
