class List < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :links
  belongs_to :user
end
