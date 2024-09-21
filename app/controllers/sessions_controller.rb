class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new; end

  def omniauth_callback
    begin
      provider = request.env['omniauth.auth'].provider
      auth = request.env['omniauth.auth']
      Rails.logger.info("auth: #{auth}")
      user = User.find_by(email: auth.info.email)

      if user.nil?
        user = User.create!
        if auth.info.has_key?(:email)
          user.update!(email: auth.info.email)
        end
      end


      if user.present?
        user.authentications.find_or_create_by(provider: provider, uid: auth.uid) do |authentication|
          authentication.name = auth.info.name
          authentication.image = auth.info.image
        end
      end

      session[:user_id] = user.id
      redirect_to users_path
    rescue => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

end
