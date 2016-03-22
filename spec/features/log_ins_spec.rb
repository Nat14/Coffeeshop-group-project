require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  it "as a user, I can visit the login page" do
    visit "/users/sign_in"
      expect(page).to have_content("Log in")
  end
end
