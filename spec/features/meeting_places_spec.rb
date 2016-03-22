require 'rails_helper'

RSpec.feature "MeetingPlaces", type: :feature do
  it "can list a current suggested meetings" do
    new_meeting
    expect(page).to have_content 'Meeting was successfully created.'
  end

  it "can list a confirmed meetings" do

  end

  def new_meeting
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 92103'
    fill_in 'Subject', with: 'Ruby on Rails'
    fill_in 'Useridtext', with: '1'
    click_button 'Create Meeting'
  end
end
