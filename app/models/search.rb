class Search < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true
  validates :keyword, :presence => true
end
