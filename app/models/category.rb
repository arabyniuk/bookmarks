class Category < ActiveRecord::Base
  validates_uniqueness_of :name, scope: :user_id

  has_many :links
  belongs_to :user

  def self.subdomain(subdomain, user_id)
    where(name: subdomain,
          user_id: user_id)
  end
end
