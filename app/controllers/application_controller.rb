class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    if session[:user_id]
      return true
    end

    error_msg = 'Please log in'

    if request.xhr?
      render :text => error_msg, :status => :internal_server_error
    else
      session[:return_to] = request.fullpath
      flash[:warning] = error_msg
      redirect_to login_path
    end
    
    return false
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to return_to
    else
      redirect_to questions_path
    end
  end
end
