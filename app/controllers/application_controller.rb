class ApplicationController < ActionController::Base

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  def authenticated?
    if session[:user_email].blank?
      session[:requested_url] = request.original_url
      return false
    end
    if session[:user_auth].blank?
      user = User.where(email_cimav: session[:user_email]).first
      session[:user_auth] = user && user.email_cimav == session[:user_email]
      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
