class DownvotesController < ApplicationController

  before_action :login_required

  
  def downvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      error_msg = 'You already downvoted this question'
      
      if request.xhr?
        render :text => error_msg, :status => :internal_server_error
      else
        flash[:error] = error_msg
        redirect_to question_path @question
      end
    else
      @downvote = @question.downvotes.create
      @downvote.user = @user
      @downvote.save

      if request.xhr?
        render :text => @question.votes
      else
        flash[:message] = 'Question downvoted'
        redirect_to question_path @question
      end
    end
    
  end
  
  def downvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      error_msg = 'You already downvoted that answer'

      if request.xhr?
        render :text => error_msg, :status => :internal_server_error
      else
        flash[:error] = 'You already downvoted that answer'
        redirect_to question_path @question
      end
    else
      @downvote = @answer.downvotes.create
      @downvote.user = @user
      @downvote.save

      if request.xhr?
        render :text => @answer.votes
      else
        flash[:message] = 'Answer downvoted'
        redirect_to question_path @question
      end
    end
    
  end

end
