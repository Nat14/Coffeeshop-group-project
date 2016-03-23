require 'rails_helper'

RSpec.feature "facebooks", type: :feature do

  describe "as a user, I can login with facebook" do
    john = User.new([{email: 'isaac.vonderau@uleth.ca'}, {password:'somethingrandom'},   {provider: "facebook"}, {uid: "794483024320"}])
    expect(john.email).to be('isaac.vonderau@uleth.ca')
  end

  describe "as a user, I can login with facebook" do
  it "as a used who registered through facebook, I cannot re-register", :js =>true do
      visit "/"
      click_link('Sign in with Facebook')
    end
  end
end
