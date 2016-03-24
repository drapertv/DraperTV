class SeriesController < InheritedResources::Base
  before_filter :set_categories_and_colors

  def index
    @og_title = "Series - DraperTV"
    @meta_description = "Watch talks given by top Silicon Valley startup founders at Draper University. Learn about startups and entrepreneurship with DraperTV on topics like Vision, Fundraising, Marketing, Product, and Sales."
    @series = Series.all.order("created_at desc")
  end

  def home_page
      @featured = Series.featured
      
      popular = Series.popular
      speakers = Series.shown_on_front_page
      livestreams = Livestream.shown_on_front_page
      students = popular
      @media = [{title: "Must Watch", content: popular}, {title: "Speakers", content: popular}, {title: "Livestreams", content: livestreams},{title: "Students", content: students}]
      @og_image = @featured.first.first_video.vthumbnail_url
  end

  def show
    @series = Series.find(params[:id])
  end

  private

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black"]
    end
end

