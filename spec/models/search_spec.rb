require 'rails_helper'


describe Search do

  it "cannot save without a keyword" do
    user = FactoryGirl.create(:user)
    user.searches << FactoryGirl.build(:search, keyword: nil)
    expect(user.searches.first.keyword).to be_nil
  end

  it "must have keyword to save" do
    user = FactoryGirl.create(:user)
    user.searches << FactoryGirl.build(:search)
    expect(user.searches.first.keyword).to include("ruby")
  end

  it "must belong to a User" do
    search =  FactoryGirl.build(:search)
    expect(search.save).to be false
    user = FactoryGirl.create(:user)

    user.searches << FactoryGirl.build(:search)
    expect(user.searches.first.keyword).to include("ruby")
  end



end
