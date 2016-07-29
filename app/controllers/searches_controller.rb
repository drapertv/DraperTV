class SearchesController < ApplicationController
  protect_from_forgery :except => :create 

  def create
    @terms = params[:search][:terms]
    Search.create terms: @terms
    @og_title = "DraperTV - Search for \"#{@terms}\""
    @results = Search.search_for(@terms).uniq
    @count = @results.count
  end

  def index
  	@terms = params[:terms]
    @og_title = "DraperTV - Search for \"#{@terms}\" - DraperTV"  	
    @results = Search.search_for(@terms).uniq
    @count = @results.count
  	render 'create'
  end
end
