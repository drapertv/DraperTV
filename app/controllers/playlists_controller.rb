class PlaylistsController < InheritedResources::Base
  # load_and_authorize_resource

  def index
    @og_title = "DraperTV - Series"

      @welcome = params[:welcome] == "true"
      @page = params[:page] || 1
      @page = @page.to_i
      @page_next = @page + 1
      @page_back = @page > 1 ? @page - 1 : 1
		  
      @playlists = Playlist.all
      @last_page = @playlists.length < 5
      @first_page = @page < 2
    if !request.original_url.split("/").last.include? "playlists"
      @popular = Playlist.all.limit(6)
      @new = Playlist.order('created_at desc').limit(6)
      @categories = ["Attitude", "Starting Up", "Fundraising", "Product", "Marketing", "Sales", "Hiring", "Finance", "Legal", "Extras"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "gray"]
      render "home_page"
    end
  end

  def new
    @playlist = Playlist.new
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def index_router
    @og_title = "DraperTV - Series"
    if !current_user
      redirect_to root_path and return
    end
    if current_user.email.nil?
      redirect_to profile_edit_path(current_user), notice: "Enter Your Email Please" 
    else
      @welcome = params[:welcome] == "true"
      @page = params[:page] || 1
      @page = @page.to_i
      @page_next = @page + 1
      @page_back = @page > 1 ? @page - 1 : 1
      @last_page = @playlists.length < 5
      @first_page = @page < 2
    end
  end

  private
	  def playlist_params
	    params.require(:playlist).permit(:title, :price, :challange_id, :video_ids,:author_id,:video_ids_raw)
	  end
end

