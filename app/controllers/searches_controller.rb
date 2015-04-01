class SearchesController < ApplicationController

  def create
    @terms = params[:search][:terms]
    Search.create terms: @terms, user_id: current_user.id
    @results = Search.search_for @terms 
  end

  private

  def search_params
    params.require(:search).permit(:terms)
  end

end
