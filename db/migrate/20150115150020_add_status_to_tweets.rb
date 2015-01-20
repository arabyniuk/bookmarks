class AddStatusToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :status, :boolean, default: true
    add_column :tweets, :actual_time, :datetime
  end
end
