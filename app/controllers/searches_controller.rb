class SearchesController < ApplicationController

  def create
    @terms = params[:search][:terms]
    Search.create terms: @terms

    @og_title = "Search for \"#{@terms}\" - DraperTV"
    
    @page = params[:page] || 1
    @page = @page.to_i
  	@page_next = @page + 1
  	@page_back = @page > 1 ? @page - 1 : 1
  	
    @results = Search.search_for(@terms).uniq
    @count = @results.count

    if !@browser.mobile?
      @results = @results.paginate(page: @page, per_page: 7)
    end
  	@last_page = @results.length < 7
    @first_page = @page < 2 
  end

  def index
  	@terms = params[:terms]
    @og_title = "Search for \"#{@terms}\" - DraperTV"
  	@page = params[:page] || 1
    @page = @page.to_i
  	@page_next = @page + 1
  	@page_back = @page > 1 ? @page - 1 : 1
  	
    @results = Search.search_for(@terms).uniq
    @count = @results.count
    @results = @results.paginate(page: @page, per_page: 9)
	  @last_page = @results.length < 7
    @first_page = @page < 2 
  	render 'create'
  end
end
