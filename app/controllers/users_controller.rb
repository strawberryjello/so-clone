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


  def profile
    @user = User.find params[:id]
    @questions = @user.questions
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
        flash.now[:error] = 'Login failed'
        render 'login'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to questions_path
  end


  def forgot_password
  end

  def do_forgot_password
    if request.post?
      user = User.find_by(:email => params[:email])
      if user and user.send_new_password
        render 'password_sent'
      else
        flash[:error] = 'Password could not be sent'
        redirect_to login_path
      end
    end
  end


  def change_password
  end

  def do_change_password
    @user = User.find session[:user_id]
    if request.post?
      @user.update_attributes(
        :password => params[:password],
        :password_confirmation => params[:password_confirmation]
      )

      if @user.save
        flash[:message] = 'Password changed'
        redirect_to questions_path
      else
        flash.now[:error] = 'Password change failed'
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
