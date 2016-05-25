class SearchController < ApplicationController

  def run
  @query = params[:query]
  puts @query
  @movies = Movie.where("title LIKE ? OR description LIKE ?", "%#{@query}%","%#{@query}%")
  end

end
