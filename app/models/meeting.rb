class Meeting < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => 'Coffee_Cup.png'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
