require 'rails_helper'

RSpec.describe Usermeeting, type: :model do

    describe "create" do
      it "Usermeeting record does exist" do
        meeting = FactoryGirl.create(:meeting)
        user = FactoryGirl.create(:user)
        usermeenting = Usermeeting.new
        usermeenting.user_id = user.id
        usermeenting.meeting_id = meeting.id
        usermeenting.owner = true
        usermeenting.save
        expect(Usermeeting.first).to be_a(Usermeeting)
        expect(Usermeeting.first.user_id).to be_truthy
        expect(Usermeeting.first.meeting_id).to be_truthy
        expect(Usermeeting.first.owner).to eq(true)
      end
    end

end
