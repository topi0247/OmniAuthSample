class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  def authenticate_user!
    if session[:user_id].nil?
      flash[:error] = 'ログインしてください'
      redirect_to root_path
    end
    @current_user ||= User.find_by(id: session[:user_id])
    Rails.logger.info("current_user: #{session[:user_id]}")
  end
end
