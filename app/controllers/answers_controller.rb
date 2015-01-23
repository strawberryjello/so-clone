class AnswersController < ApplicationController

  before_action :login_required

  
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create answer_params
    @user = User.find session[:user_id]
    @answer.user = @user
    if !@answer.save
      flash[:error] = 'Cannot post empty answer'
    end
    
    redirect_to question_path @question
  end


  def destroy
    @question = Question.find params[:question_id]
    @answer = @question.answers.find params[:id]
    @answer.destroy
    redirect_to question_path @question
  end





  private

  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
