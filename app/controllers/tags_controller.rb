class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  

  def show
    @tag = Tag.find params[:id]
    @questions = @tag.questions
  end

  
  def search
    @original_search = params[:search_string].strip
    search_string = "%#{@original_search.downcase}%"
    @results = Tag.where('name like ?', search_string)
    if !@original_search.empty? and @results.any?
      render 'search'
    else
      flash[:warning] = 'No matching tags found'
      redirect_to tags_path
    end
  end

end
