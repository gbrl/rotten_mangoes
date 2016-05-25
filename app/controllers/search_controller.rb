class SearchController < ApplicationController

  def show
    @params = params

    @title = ""
    @director = ""
    @duration = ""
    
    @query = params[:title_or_director].to_s 
    @duration_query = params[:duration].to_s if params[:title_or_director].to_s == "" && params[:duration].to_s != "choose one..."

    @duration = params[:duration].to_s if params.has_key? :duration

    case @duration
    when "under 90 minutes" 
      @movies = Movie.short.where("title LIKE ? OR director LIKE ?", "%#{@query}%","%#{@query}%")
    when "between 90 and 120 minutes" 
      @movies = Movie.medium.where("title LIKE ? OR director LIKE ?", "%#{@query}%","%#{@query}%")
    when "over 120 minutes"
      @movies = Movie.long.where("title LIKE ? OR director LIKE ?", "%#{@query}%","%#{@query}%")
    else
      @movies = Movie.where("title LIKE ? OR director LIKE ?", "%#{@query}%","%#{@query}%")
    end

    @movies = [] unless params[:duration] && params[:title_or_director]
    
  end

end
