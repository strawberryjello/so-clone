class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    if session[:user_id]
      return true
    end

    session[:return_to] = request.fullpath
    flash[:warning] = 'Please log in to continue'
    redirect_to users_login_path
    return false
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to return_to
    end
  end
end
