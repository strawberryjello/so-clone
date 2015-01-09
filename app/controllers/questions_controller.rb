class QuestionsController < ApplicationController

  before_action :login_required, :except => [:index, :show]
  
  def index
    @questions = Question.all
  end
  

  def new
    @question = Question.new
  end


  def edit
    @question = Question.find params[:id]
  end

  
  def create
    user = User.find session[:user_id]
    @question = user.questions.create question_params

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end


  def update
    user = User.find session[:user_id]
    @question = Question.find params[:id]

    if @question.update question_params
      redirect_to @question
    else
      render 'edit'
    end
  end


  def show
    @question = Question.find params[:id]
  end


  def destroy
    user = User.find session[:user_id]
    @question = Question.find params[:id]
    @question.destroy

    redirect_to questions_path
  end




  
  private

  def question_params
    params.require(:question).permit(:title, :text)
  end
end
