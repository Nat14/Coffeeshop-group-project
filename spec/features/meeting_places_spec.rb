require 'rails_helper'

RSpec.feature "MeetingPlaces", type: :feature do
  it "can list a current suggested meetings" do
    visit 'meetings/new'
    fill_in 'Address', with: '100 Main St. San Diego 92103'
    fill_in 'Subject', with: 'Ruby on Rails'
    fill_in 'Useridtext', with: '1'
    click_button 'Create Meeting'
    expect(page).to have_content 'Meeting was successfully created.'
  end
end
