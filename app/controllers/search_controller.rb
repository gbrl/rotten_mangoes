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
      duration_min = 0
      duration_max = 90
    when "Between 90 and 120 minutes" 
      duration_min = 90
      duration_max = 120
    when "Over 120 minutes"
      duration_min = 120
      duration_max = 9999999
    else
      duration_min = 0
      duration_max = 9999999
    end

     @movies = Movie.where("title LIKE ? AND director LIKE ? AND runtime_in_minutes BETWEEN ? AND ?", "%#{@title}%","%#{@director}%","#{duration_min}","#{duration_max}")
  end

end
