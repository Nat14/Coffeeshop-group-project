class Meeting < ActiveRecord::Base
  has_many :usermeetings
  has_many :users, through: :usermeetings

  has_many :posts
end
