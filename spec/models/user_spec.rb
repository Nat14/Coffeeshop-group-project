require 'rails_helper'


RSpec.describe User, type: :model do

  describe "create" do
    it "cannot save without an email" do
      user = FactoryGirl.build(:user, email: nil)
      expect(user).not_to be_valid
    end
    it "cannot save without an username" do
      user = FactoryGirl.build(:user, username: nil)
      expect(user).not_to be_valid
    end
    it "cannot save without an password" do
      user = FactoryGirl.build(:user, password: nil)
      expect(user).not_to be_valid
    end
    it "can have an avatar" do
      user = FactoryGirl.build(:user, avatar: Rack::Test::UploadedFile.new(Rails.root + 'spec/Images/coffeecup.jpeg', 'image/jpeg'))
      expect(user).to be_valid
      user = FactoryGirl.build(:user, avatar: nil)
      expect(user).to be_valid
    end
    it "can have an address" do
      user = FactoryGirl.build(:user, address: "2241 Garnet Ave")
      expect(user).to be_valid
      user = FactoryGirl.build(:user, address: nil)
      expect(user).to be_valid
    end
    it "can have a provider" do
      user = FactoryGirl.build(:user, provider: "facebook")
      expect(user).to be_valid
      user = FactoryGirl.build(:user, provider: nil)
      expect(user).to be_valid
    end
  end

end
