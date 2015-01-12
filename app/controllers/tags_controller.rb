class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  

  def show
    @tag = Tag.find params[:id]
    @questions = @tag.questions
  end

  
  def search
    # need to enclose the search string in %%, but it has to be sanitized
    results = Tag.where("name like ?", params[:search_string].downcase)
    if results.any?
      # render the results here
    else
      flash[:message] = 'No matching tags found'
      redirect_to tags_path
    end
  end


  def search_results
    
  end
end
