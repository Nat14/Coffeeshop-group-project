class Meeting < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  has_many :usermeetings
  has_many :users, through: :usermeetings
end
