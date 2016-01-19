class TwitterController < ApplicationController
  layout 'twitter'
  include PathFormatter

  def index
    if twitter_user_signed_in?
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
    delete_delayed_job(@delayed_job_id)
    @tweet.destroy
    respond_to do |format|
      format.js
    end
  end

  def tweet
    return nil if decode_path.empty?

    if is_there_path_text?
      allow_twitter_msg
    elsif is_there_path_text_with_time?
      allow_twitter_msg_with_delay_job
    end
    redirect_to root_url(subdomain: 'tweet')
  end

  private

  def allow_twitter_msg
    Tweet.create(body: decode_path_text,
                 user_id: current_user.id,
                 delay: Time.now)
    twitter_job
  end

  def allow_twitter_msg_with_delay_job
    Tweet.create(body: decode_path_text,
                 user_id: current_user.id,
                 delay: tweet_delay_minutes,
                 delayed_job_id: twitter_job(delay=true).id)
  end

  def twitter_job(delay=false)
    if delay
      current_user.twitter
                  .delay(run_at: decode_path_delay_to_min)
                  .update(decode_path_text)
    else
      current_user.twitter.update(decode_path_text)
    end
  end

  def delete_delayed_job(job)
    Delayed::Job.find(@delayed_job_id).delete
  rescue Exception => e
    puts e
  end
end
