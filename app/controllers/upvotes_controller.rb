class UpvotesController < ApplicationController

  before_action :login_required


  def upvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      Downvote.cancel(@question.id, @user.id)

      resolve_update @question.votes, @question

    elsif Upvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      error_msg = 'You already upvoted this question'

      resolve_duplicate error_msg

    else
      @upvote = @question.upvotes.create
      @upvote.user = @user
      @upvote.save

      resolve_update @question.votes, @question
    end
  end

  
  def upvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      Downvote.cancel(@answer.id, @user.id)

      resolve_update @answer.votes, @question

    elsif Upvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      error_msg = 'You already upvoted that answer'

      resolve_duplicate error_msg
      
    else
      @upvote = @answer.upvotes.create
      @upvote.user = @user
      @upvote.save

      resolve_update @answer.votes, @question
    end
  end





  private

  def resolve_duplicate error_msg
    if request.xhr?
      render :text => error_msg, :status => :internal_server_error
    else
      flash[:error] = error_msg
      redirect_to @question
    end
  end


  def resolve_update votes, redirect_instance
    if request.xhr?
      render :text => votes
    else
      redirect_to redirect_instance
    end
  end

end
