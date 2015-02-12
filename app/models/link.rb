class Link < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :title, presence: true
  
  def self.last_week
    where("created_at >= ?", Time.now - 1.week)
  end
end
