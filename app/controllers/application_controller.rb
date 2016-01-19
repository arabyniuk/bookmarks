class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twitter_user_signed_in?
    user_signed_in? && current_user.provider == 'twitter'
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    root_url(subdomain: false)
  end
end
