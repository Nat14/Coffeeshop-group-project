require 'rails_helper'

describe Search do

  it "cannot save without a keyword" do
    user = User.new
    user.email = 'J@yahoo.com'
    user.password = 'password123'
    user.avatar =  File.new('/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    user.save
    user.searches << Search.new()
    expect(user.searches.first.keyword).to be_nil

  end

  it "must have keyword to save" do
    user = User.new
    user.email = 'J@yahoo.com'
    user.password = 'password123'
    user.avatar =  File.new('/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    user.save
    user.searches << Search.new(keyword: "ruby")
    expect(user.searches.first.keyword).to include("ruby")
  end

  it "must belong to a User" do
    search =  Search.new(keyword: "ruby")
    expect(search.save).to be false

    user = User.new
    user.email = 'J@yahoo.com'
    user.password = 'password123'
    user.avatar =  File.new('/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    user.save
    user.searches << Search.new(keyword: "ruby")
    expect(user.searches.first.keyword).to include("ruby")
  end


end
