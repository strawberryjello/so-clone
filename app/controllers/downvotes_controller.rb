class DownvotesController < ApplicationController

  before_action :login_required

  
  def downvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Upvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      Upvote.cancel(@question.id, @user.id)

      resolve_update @question.votes, @question
      
    elsif Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      error_msg = 'You already downvoted this question'
      
      resolve_duplicate error_msg
      
    else
      @downvote = @question.downvotes.create
      @downvote.user = @user
      @downvote.save

      resolve_update @question.votes, @question
    end
    
  end
  
  def downvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    if Upvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      Upvote.cancel(@answer.id, @user.id)

      resolve_update @answer.votes, @question
      
    elsif Downvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      error_msg = 'You already downvoted that answer'

      resolve_duplicate error_msg
      
    else
      @downvote = @answer.downvotes.create
      @downvote.user = @user
      @downvote.save

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
