class DownvotesController < ApplicationController

  
  def downvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      if request.xhr?
        render :nothing => true, :status => :internal_server_error
      else
        flash[:error] = 'You have already downvoted this question'
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
      respond_to do |format|
        format.html do
          flash[:error] = 'You have already downvoted that answer'
          redirect_to question_path @question
        end

        format.js { render 'downvote_answer_error' }
      end
    else
      @downvote = @answer.downvotes.create
      @downvote.user = @user
      @downvote.save

      respond_to do |format|
        format.html do
          flash[:message] = 'Answer downvoted'
          redirect_to question_path @question
        end

        format.js { render 'answers/vote_answer' }
      end
    end
    
  end

end
