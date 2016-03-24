class Meeting < ActiveRecord::Base
  has_many :usermeetings
  has_many :users, through: :usermeetings
end
