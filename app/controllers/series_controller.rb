class SeriesController < InheritedResources::Base
  before_filter :set_categories_and_colors

  def index
    @og_title = "Series - DraperTV"
    @meta_description = "Watch talks given by top Silicon Valley startup founders at Draper University. Learn about startups and entrepreneurship with DraperTV on topics like Vision, Fundraising, Marketing, Product, and Sales."

    if params[:list] == "true"
      quantity = params[:quantity]
      if params[:sorted_by]
        @series = Series.offset(params[:offset]).order("#{params[:sorted_by]} #{params[:order]}").limit(params[:quantity])
      else
        @series = Series.offset(params[:offset]).order('created_at desc').limit(params[:quantity])
      end
      render partial: "list" and return
    end
  end

  def home_page
      @featured = Series.featured
      popular = Series.popular
      speakers = Series.newest
      livestreams = Livestream.closest_to_now
      
      students = popular #to be implemented when we finish creating student videos

      @media = [{title: "Must Watch", content: popular}, {title: "Speakers", content: speakers}, {title: "Livestreams", content: livestreams},{title: "Students", content: students}]
      
      @og_image = @featured.first.vthumbnail_url
  end

  def director
    slug = params[:series_slug]
    series = Series.find_by_slug slug
    redirect_to video_path series.first_video
  end
  
  private

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black"]
    end
end

