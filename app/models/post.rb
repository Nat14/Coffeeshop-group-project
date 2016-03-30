class Post < ActiveRecord::Base
  validates :description, presence: true

  belongs_to :user
  belongs_to :meeting
end
