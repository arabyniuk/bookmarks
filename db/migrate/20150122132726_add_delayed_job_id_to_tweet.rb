class AddDelayedJobIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :delayed_job_id, :integer
  end
end
