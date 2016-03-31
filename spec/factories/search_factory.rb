FactoryGirl.define do
  factory :user do
    username "User5"
    email "r@yahoo.com"
    password "beignet1"
    avatar Rack::Test::UploadedFile.new(Rails.root + 'spec/Images/coffeecup.jpeg', 'image/jpeg')
  end

  factory :search do
    keyword "ruby"
  end
end
