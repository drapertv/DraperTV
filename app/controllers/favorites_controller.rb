class FavoritesController < ApplicationController


  def index
  	@videos = current_user.get_voted Video
  	@playlists = current_user.get_voted Playlist
  	@challenges = current_user.get_voted Challenge
  end

  def create
    model = params[:model_name].constantize.find(params[:model_id])
    
    if current_user.voted_for? model
      model.unliked_by current_user
    else
      model.liked_by current_user
    end
    
    render json: {like_count: model.get_likes.size}
  end

end
