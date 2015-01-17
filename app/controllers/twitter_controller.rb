class TwitterController < ApplicationController
  layout 'twitter'

  def index
    unless user_signed_in? || current_user.provider == 'twitter'
      error
    else
      @tweets = Tweet.order('created_at DESC').limit(20)
      tweet
    end
  end

  def error
    flash[:notice] = 'You are not authorized as twitter user' 
    redirect_to root_url(subdomain: false)
  end
  
  def tweet
    original_path = URI.decode(request.original_fullpath.gsub(/^\//, ""))
    unless original_path.empty?
      path = original_path.gsub(/\&[d]=[0-9]*/, "")
      delay = original_path.match(/\&[d]=[0-9]*/)
      if (!path.nil? && delay.nil?)
        tweet = Tweet.new({body: path, user_id: current_user.id})
        tweet.save
        #current_user.twitter.update(path)
        redirect_to root_url(subdomain: 'tweet')
      elsif !path.nil? && !delay.nil?
        delay = delay.to_s.scan(/\d+$/).first.to_i
        tweet = Tweet.new({body: path, user_id: current_user.id, status: false})
        tweet.save
        #current_user.twitter.delay(run_at: delay.minutes.from_now).update(path).update_tweet(tweet)
        #tweet.delay(run_at: delay.minutes.from_now).update_attribute(:status, true)
      end
    end 
  end
  
end
