class UsersController < ApplicationController

  
  def new
    @user = User.new
  end


  def create
    @user = User.new user_params

    if request.post?
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        redirect_to questions_path
      else
        render 'new'
      end
    end
  end

  def login
  end

  def do_login
    if request.post?
      if session[:user] = User.authenticate(params[:login], params[:password])
        redirect_to questions_path
      else
        render 'login'
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to questions_path
  end





  private

  def user_params
    params.
      require(:user).
      permit(:login, :password, :password_confirmation, :email)
  end
end