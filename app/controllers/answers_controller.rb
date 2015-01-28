class AnswersController < ApplicationController

  before_action :login_required

  
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create answer_params
    @user = User.find session[:user_id]
    @answer.user = @user

    respond_to do |format| 
      unless @answer.save
        flash[:error] = 'Cannot post empty answer'
      end
      
      format.html { redirect_to question_path @question }
      format.js {}
    end
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
