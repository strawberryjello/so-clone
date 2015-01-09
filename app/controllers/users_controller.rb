class UsersController < ApplicationController
  
  def new
    @user = User.new
  end


  def create
    @user = User.new user_params

    if request.post?
      if @user.save
        user = User.authenticate @user.login, @user.password
        session[:user_id] = user[:id]
        session[:username] = user[:login]
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
      user = User.authenticate params[:login], params[:password]
      if user
        session[:user_id] = user[:id]
        session[:username] = user[:login]
        redirect_to_stored
      else
        flash[:warning] = 'Login failed'
        render 'login'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to questions_path
  end

  def change_password
  end
  
  def do_change_password
    @user = User.find(session[:user_id])
    if request.post?
      @user.update_attributes(
        :password => params[:password],
        :password_confirmation => params[:password_confirmation]
      )

      if @user.save
        flash[:message] = 'Password changed'
        redirect_to questions_path
      else
        flash[:warning] = 'Password change failed'
        render 'change_password'
      end
    end
  end





  private

  def user_params
    params.
      require(:user).
      permit(:login, :password, :password_confirmation, :email)
  end
end
