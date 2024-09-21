class SessionsController < ApplicationController
  def new; end

  def omniauth_callback
    begin
      provider = request.env['omniauth.auth'].provider
      @auth = request.env['omniauth.auth']
      @user = User.find_by(email: auth.info.email)

      if @user.nil?
        user = User.create(email: auth.info.email)
      end

      if @user.persisted?
        @user.authentications.create(provider: auth.provider, uid: auth.uid, name: auth.info.name, image: auth.info.image)
      end

      session[:user_id] = @user.id
      redirect_to users_path
    rescue => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  private
end
