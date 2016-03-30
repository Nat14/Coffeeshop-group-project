class Meeting < ActiveRecord::Base
  validates :address, presence: true
  validates :subject, presence: true

  geocoded_by :address
  after_validation :geocode

  has_many :usermeetings
  has_many :users, through: :usermeetings

  has_many :posts

  # for receiving extra fields in meeting form
  attr_accessor :description
  attr_accessor :meetingdate
end
