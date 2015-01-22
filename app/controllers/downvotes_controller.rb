class DownvotesController < ApplicationController

  
  def downvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Downvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      flash[:error] = 'You have already downvoted this question'
    else
      flash[:message] = 'Question downvoted'
      @downvote = @question.downvotes.create
      @downvote.user = @user
      @downvote.save
    end
    
    redirect_to question_path @question
  end
  

end
