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
    session[:return_to] = request.fullpath
  end

  
  def create
    user = User.find session[:user_id]
    @question = user.questions.create question_params

    if @question.save
      tags = Tag.parse_tag_string @question.tag_string
      @question.add_tags tags
      redirect_to @question
    else
      render 'new'
    end
  end


  def update
    user = User.find session[:user_id]
    @question = Question.find params[:id]

    if @question.update question_params
      tags = Tag.parse_tag_string @question.tag_string
      @question.add_tags tags
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


  def untag
    @question = Question.find params[:id]
    tag = Tag.find params[:tag_id]
    @question.tags.delete tag

    redirect_to_stored
  end




  
  private

  def question_params
    params.require(:question).permit(:title, :text, :tag_string)
  end
end
