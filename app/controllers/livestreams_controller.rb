class LivestreamsController < InheritedResources::Base

  before_filter :set_categories_and_colors, only: ["show", "index"]

  def show
    @livestream = Livestream.friendly.find(params[:id])
    @media = {title: "Similar", content: Series.popular}

    @og_title = "#{@livestream.title} - DraperTV"
    @og_description = @livestream.description
    @meta_description = @livestream.description
    @og_image = @livestream.vthumbnail_url
  end

  def index
    @og_title = "Livestreams - DraperTV "
    @og_description = "Livestreaming the best of Silicon Valley"
    @meta_description = "Watch live as top Silicon Valley speakers teach startup skills and entrepreneurship at Draper University. Be part of the action on DraperTV with live Q&A through @Draper_U on Twitter."
   
    @current_livestreams = Livestream.current.order('stream_date asc')
    @upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    @future_livestreams = (@current_livestreams + @upcoming_livestreams)

    @media = [{title: "Upcoming & Live Events", content: @future_livestreams}, {title: "Archived Events", content: [], lazy_load: "lazy-load"}]

    if params[:list] == "true"
      quantity = params[:quantity]
      @livestreams = Livestream.past.offset(params[:offset]).order('created_at desc').limit(params[:quantity])
      render partial: "list" and return
    end

  end

  def hidebanner
    if params["hide_type"] == "livestream"
      session[:hidden_livestream_id] = Livestream.next_livestream.id
      render json: {hidden_id: Livestream.next_livestream.id}
    else
      session[:hide_application_link] = true
      render nothing: true;
    end
  end

  private

   def set_categories_and_colors
    @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
    @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
  end



end