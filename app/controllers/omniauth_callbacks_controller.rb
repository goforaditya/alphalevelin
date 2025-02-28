class OmniauthCallbacksController < ApplicationController
  def github
    handle_auth "Github"
  end

  def google_oauth2
    handle_auth "Google"
  end

  private

  def handle_auth(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      session[:user_id] = @user.id
      flash[:notice] = "Successfully signed in with #{provider}"
      redirect_to root_path
    else
      flash[:alert] = "There was a problem signing in with #{provider}"
      redirect_to signin_path
    end
  end
end