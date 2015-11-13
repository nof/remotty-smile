class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    redirect_to '/auth/remotty'
  end

  def create
    user = User.find_or_create_with_omniauth(request.env['omniauth.auth'])
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, notice: 'ログインしました'
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました'
  end

  def failure
    redirect_to root_url, alert: 'Remottyログインに失敗しました'
  end
end
