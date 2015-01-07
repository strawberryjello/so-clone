class UsersController < ApplicationController

  
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    # authenticate
    # save
    # redirect
  end





  private

  def user_params
    params.
      require(:user).
      permit(:login, :password, :password_confirmation, :email)
  end
end
