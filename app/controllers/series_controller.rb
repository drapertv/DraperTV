class SeriesController < InheritedResources::Base
  before_filter :set_categories_and_colors, only: ["index", "show"]

  def index
    @og_title = "Series - DraperTV"
    @meta_description = "Watch talks given by top Silicon Valley startup founders at Draper University. Learn about startups and entrepreneurship with DraperTV on topics like Vision, Fundraising, Marketing, Product, and Sales."
    @series = Series.all.order("created_at desc")

    if params[:category]
      @category = params[:category]
      @color = @colors[@categories.find_index(@category)]
      @series = Series.tagged_with(params[:category].upcase)
    end

    indexes = (1..@series.count).to_a.reject! {|n| n % 9 != 8}
    indexes.each do |i|
      if !params[:category]
        chapter = Chapter.all.sample
        @series = @series.to_a.insert(i - 1, chapter)
      else
        @series = @series.to_a.insert(i - 1, Chapter.where(topic_name: params[:category].upcase).all.sample)
      end
    end

    # if requesting the homepage
    if !request.original_url.split("/").last.include? "series"
      @featured = Series.where(show_on_front_page: true)
      @popular = Series.popular
      @og_title = "DraperTV"
      @og_image = @featured.first.first_video.vthumbnail_url
      
      @featured = Series.all.limit(6) if @featured.length < 1
      @popular = Series.all.limit(6) if @popular.length < 1
      @popular = @popular.to_a.insert(2, Chapter.all.sample)
      @new = Series.order('created_at desc').limit(6)
      render "home_page"
    end
  end

  def show
    @series = Series.find(params[:id])
  end

  private

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
    end
end

