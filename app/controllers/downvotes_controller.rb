class DownvotesController < ApplicationController

  
  def downvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      respond_to do |format|
        format.html do
          flash[:error] = 'You have already downvoted this question'
          redirect_to question_path @question
        end

        format.js { render 'downvote_question_error' }
      end
    else
      @downvote = @question.downvotes.create
      @downvote.user = @user
      @downvote.save

      respond_to do |format|
        format.html do
          flash[:message] = 'Question downvoted'
          redirect_to question_path @question
        end

        format.js { render 'questions/vote_question' }
      end
    end
    
  end
  
  def downvote_answer
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:answer_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @answer.id, :user_id => @user.id)
      flash[:error] = 'You have already downvoted that answer'
    else
      flash[:message] = 'Answer downvoted'
      @downvote = @answer.downvotes.create
      @downvote.user = @user
      @downvote.save
    end
    
    redirect_to question_path @question
  end

end
