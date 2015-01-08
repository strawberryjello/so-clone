class UsersController < ApplicationController

  
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if request.post?
      if @user.save
        # authenticate
        redirect_to questions_path
      else
        render 'new'
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
