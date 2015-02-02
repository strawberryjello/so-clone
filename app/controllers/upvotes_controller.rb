class UpvotesController < ApplicationController

  before_action :login_required


  def upvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    error_msg = 'You already upvoted this question'

    if Upvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      if request.xhr?
        render :text => error_msg, :status => :internal_server_error
      else
        flash[:error] = error_msg
        redirect_to @question
      end
    else
      @upvote = @question.upvotes.create
      @upvote.user = @user
      @upvote.save

      if request.xhr?
        render :text => @question.votes
      else
        flash[:message] = 'Question upvoted'
        redirect_to @question
      end
    end
  end

  def upvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    error_msg = 'You already upvoted this answer'

    if Upvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      if request.xhr?
        render :text => error_msg, :status => :internal_server_error
      else
        flash[:error] = error_msg
        redirect_to question_path @question
      end
    else
      @upvote = @answer.upvotes.create
      @upvote.user = @user
      @upvote.save

      if request.xhr?
        render :text => @answer.votes
      else
        flash[:message] = 'Answer upvoted'
        redirect_to question_path @question
      end
    end
    
  end

end
