class PlaylistsController < InheritedResources::Base
  before_filter :set_categories_and_colors, only: ["index", "show"]

  def index
    @og_title = "Series - DraperTV"
    @meta_description = "Watch talks given by top Silicon Valley startup founders at Draper University. Learn about startups and entrepreneurship with DraperTV on topics like Vision, Fundraising, Marketing, Product, and Sales."
    @playlists = Playlist.all.order("created_at desc")

    if params[:category]
      @category = params[:category]
      @color = @colors[@categories.find_index(@category)]
      @playlists = Playlist.tagged_with(params[:category].upcase)
    end

    indexes = (1..@playlists.count).to_a.reject! {|n| n % 6 != 5}
    indexes.each do |i|
      if !params[:category]
        chapter = Chapter.all.sample
        @playlists = @playlists.to_a.insert(i - 1, chapter)
        p chapter
      else
        @playlists = @playlists.to_a.insert(i - 1, Chapter.where(topic_name: params[:category].upcase).all.sample)
      end
    end

    # if requesting the homepage
    if !request.original_url.split("/").last.include? "playlists"
      @featured = Playlist.where(show_on_front_page: true)
      @popular = Playlist.popular

      @og_title = "DraperTV"
      @og_image = @featured.first.first_video.vthumbnail_url
      
      @featured = Playlist.all.limit(6) if @featured.length < 1
      @popular = Playlist.all.limit(6) if @popular.length < 1
      @popular[2] = Chapter.all.sample
      @new = Playlist.order('created_at desc').limit(6)
      render "home_page"
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  private

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
    end
end

