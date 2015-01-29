class UpvotesController < ApplicationController

  before_action :login_required


  def upvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Upvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      respond_to do |format|
        format.html do
          flash[:error] = 'You already upvoted this question'
          redirect_to @question
        end
        
        format.js { render 'upvote_question_error' }
      end
    else
      @upvote = @question.upvotes.create
      @upvote.user = @user
      @upvote.save
      
      respond_to do |format|
        format.html do
          flash[:message] = 'Question upvoted'
          redirect_to @question
        end
        
        format.js {}
      end
    end
    
  end

  def upvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    if Upvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      flash[:error] = 'You have already upvoted this answer'
    else
      flash[:message] = 'Answer upvoted'
      @upvote = @answer.upvotes.create
      @upvote.user = @user
      @upvote.save
    end
    
    redirect_to question_path @question
  end

end
