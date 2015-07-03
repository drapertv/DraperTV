class PlaylistsController < InheritedResources::Base
  before_filter :set_categories_and_colors, only: ["index", "show"]

  def index
    @og_title = "Series - DraperTV"
    @playlists = Playlist.all.order("created_at desc")

    if params[:category]
      @category = params[:category]
      @color = @colors[@categories.find_index(@category)]
      @playlists = Playlist.tagged_with(params[:category].upcase)
    end

    # if requesting the homepage
    if !request.original_url.split("/").last.include? "playlists"
      @featured = Playlist.where(show_on_front_page: true)
      @popular = Playlist.popular

      @og_title = "DraperTV"
      @og_image = @featured.first.first_video.vthumbnail_url
      
      @featured = Playlist.all.limit(6) if @featured.length < 1
      @popular = Playlist.all.limit(6) if @popular.length < 1
      @new = Playlist.order('created_at desc').limit(6)
      render "home_page"
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  private

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Fundraising", "Product", "Marketing", "Sales", "Hiring", "Finance", "Legal", "Auxiliary"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
    end
end

