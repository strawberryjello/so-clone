class AnswersController < ApplicationController

  before_action :login_required

  
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create answer_params
    @user = User.find session[:user_id]
    @answer.user = @user

    respond_to do |format| 
      if @answer.save
        format.html { redirect_to @question }
        format.js {}
      else
        format.html do
          flash[:error] = 'Cannot post question'
          redirect_to @question
        end
        # render a different .js.erb
        format.js { render 'create_error' }
      end
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
