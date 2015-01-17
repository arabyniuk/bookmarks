class AddStatusToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :status, :boolean, default: true
  end
end
