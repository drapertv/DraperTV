class PlaylistsController < InheritedResources::Base
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if current_user.email.nil?
      redirect_to profile_edit_path(current_user), notice: "Enter Your Email Please"
    else
		@playlists = Playlist.all
    end
  end

  def new
    @playlist = Playlist.new
  end

	def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  private
	  def set_playlist
	    @playlist = Playlist.find(params[:id])
	  end

	  def playlist_params
	    params.require(:playlist).permit(:title, :price, :challange_id, :video_ids,:author_id,:video_ids_raw)
	  end
end

