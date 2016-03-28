require 'rails_helper'

RSpec.feature "facebooks", type: :feature,  js:true do

  describe "User is able to log in with Facebook" do

    it "goes to Facebook login page" do
      visit "/"
      expect(page).to have_content("Sign in with Facebook")
    end


    # this test needs to be redone once we have a developper key for FB
    it "goes to the Facebook login page" do
      visit "/"
      click_link "Sign in with Facebook"
      expect(page).to have_content("Given URL is not allowed")
    end

  end

end
