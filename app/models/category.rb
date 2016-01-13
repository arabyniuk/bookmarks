class Category < ActiveRecord::Base
  validates_uniqueness_of :name, scope: :user_id

  has_many :links
  belongs_to :user
end
