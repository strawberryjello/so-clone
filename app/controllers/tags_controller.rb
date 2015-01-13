class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  

  def show
    @tag = Tag.find params[:id]
    @questions = @tag.questions
  end

  
  def search
    @original_search = params[:search_string]
    search_string = "%#{params[:search_string].downcase}%"
    @results = Tag.where('name like ?', search_string).to_a
    if @results.any?
      render 'search'
    else
      flash[:message] = 'No matching tags found'
      redirect_to tags_path
    end
  end

end
