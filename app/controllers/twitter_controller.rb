class TwitterController < ApplicationController
  layout 'twitter'

  def index
    if user_signed_in? && current_user.provider == 'twitter'
      @tweets = Tweet.order('created_at DESC').limit(20)
      tweet
    else
      flash[:notice] = 'You are not authorized as twitter user'
      redirect_to root_url(subdomain: false)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @delayed_job_id = @tweet.delayed_job_id
    Delayed::Job.find(@delayed_job_id).delete
    @tweet.destroy
    respond_to do |format|
      format.js
    end
  end

  def tweet
    original_path = URI.decode(request.original_fullpath.gsub(/^\//, ""))
    unless original_path.empty?
      path = original_path.gsub(/\&[d]=[0-9]*/, "")
      delay = original_path.match(/\&[d]=[0-9]*/)
      if (!path.nil? && delay.nil?)
        tweet = Tweet.new({body: path, user_id: current_user.id, delay: Time.now})
        tweet.save
        current_user.twitter.update(path)
        redirect_to root_url(subdomain: 'tweet')
      elsif !path.nil? && !delay.nil?
        delay = delay.to_s.scan(/\d+$/).first.to_i
        job = current_user.twitter.delay(run_at: delay.minutes.from_now).update(path)
        tweet = Tweet.new({body: path, user_id: current_user.id, delay: Time.now + delay.minutes, delayed_job_id: job.id})
        tweet.save
        redirect_to root_url(subdomain: 'tweet')
      end
    end
  end
end
