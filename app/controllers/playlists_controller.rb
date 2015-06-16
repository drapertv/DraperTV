class PlaylistsController < InheritedResources::Base
  # load_and_authorize_resource

  def index
    @og_title = "DraperTV - Series"
    @playlists = Playlist.all
    if params[:category]
      @playlists = Playlist.tagged_with(params[:category].upcase)
    end
    @categories = ["Attitude", "Starting Up", "Fundraising", "Product", "Marketing", "Sales", "Hiring", "Finance", "Legal", "Auxiliary"]
    @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "gray"]
    if !request.original_url.split("/").last.include? "playlists"
      @featured = Playlist.where(show_on_front_page: true)
      @popular = Playlist.popular

      @featured = Playlist.all.limit(6) if @featured.length < 1
      @popular = Playlist.all.limit(6) if @popular.length < 1
      @new = Playlist.order('created_at desc').limit(6)
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

