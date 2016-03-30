require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:meeting2) { FactoryGirl.create(:meeting) }

  describe "create" do
    it "meeting is not saved if no address provided" do
      meeting = FactoryGirl.build(:meeting, address: '')
      expect(meeting).to be_a(Meeting)
      expect(meeting).not_to be_valid
    end

    it "meeting is not saved if no subject provided" do
      meeting = FactoryGirl.build(:meeting, subject: '')
      expect(meeting).not_to be_valid
    end
  end

  describe "update" do
    it "meeting is updated when address changed" do
      meeting2.update(address: '200 main st. San Diego 9000')
      expect(Meeting.first.address).to eq('200 main st. San Diego 9000')
    end

    it "meeting is updated when subject changed" do
      meeting2.update(subject: 'Ruby on Rails')
      expect(Meeting.first.subject).to eq('Ruby on Rails')
    end
  end

  describe "delete" do
    it "meeting can be deleted" do
      meeting = FactoryGirl.create(:meeting)
      expect(Meeting.all.count).to eq(1)
      meeting.destroy
      expect(Meeting.all.count).to eq(0)
    end
  end


end
