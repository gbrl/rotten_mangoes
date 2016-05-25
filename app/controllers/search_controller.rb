class SearchController < ApplicationController

  def show
    @params = params

    @title = ""
    @director = ""
    @duration = ""
    
    @title = params[:title].to_s if params[:title]
    @director = params[:director].to_s if params[:director]
    
    @duration = params[:duration].to_s if params[:duration]


    case @duration
    when "Under 90 minutes" 
      @movies = Movie.short.where("title LIKE ? AND director LIKE ?", "%#{@title}%","%#{@director}%")
    when "Between 90 and 120 minutes" 
      @movies = Movie.medium.where("title LIKE ? AND director LIKE ?", "%#{@title}%","%#{@director}%")
    when "Over 120 minutes"
      @movies = Movie.long.where("title LIKE ? AND director LIKE ?", "%#{@title}%","%#{@director}%")
    else
      @movies = Movie.where("title LIKE ? AND director LIKE ?", "%#{@title}%","%#{@director}%")
    end

    @movies = [] unless params[:duration] && params[:director] && params[:title]
    
  end

end
