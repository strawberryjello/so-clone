class UpvotesController < ApplicationController

  before_action :login_required


  def upvote_question
    @question = Question.find params[:question_id]
    @user = User.find session[:user_id]

    if Upvote.exists?(:voteable_id => @question.id, :user_id => @user.id)
      flash[:error] = 'You have already upvoted this question'
    else
      flash[:message] = 'Question upvoted'
      @upvote = @question.upvotes.create
      @upvote.user = @user
      @upvote.save
    end
    
    redirect_to question_path @question
  end
end
