class SearchesController < ApplicationController
  before_filter :set_categories_and_colors
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

  private 

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
    end

end
