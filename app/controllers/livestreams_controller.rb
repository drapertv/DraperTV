class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.friendly.find(params[:id])
    @media = {title: "Similar Videos", content: Series.popular}

    @og_title = "#{@livestream.title} - DraperTV"
    @og_description = @livestream.description
    @meta_description = @livestream.description
    @og_image = @livestream.vthumbnail_url
  end

  def index
    @og_title = "Livestreams - DraperTV "
    @og_description = "Livestreaming the best of Silicon Valley"
    @meta_description = "Watch live as top Silicon Valley speakers teach startup skills and entrepreneurship at Draper University. Be part of the action on DraperTV with live Q&A through @Draper_U on Twitter."
   
    if params[:list] == "true" # ajax call from fetchMedia function in mediaIndexUI.js.coffee
      quantity = params[:quantity]
      @livestreams = Livestream.past.offset(params[:offset]).order('created_at desc').limit(params[:quantity])
      render partial: "list" and return
    end
    @current_livestreams = Livestream.current.order('stream_date asc')
    @upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    @future_livestreams = (@current_livestreams + @upcoming_livestreams)

    @media = [{title: "Upcoming & Live Events", content: @future_livestreams, hide: @future_livestreams.empty? }, {title: "Archived Events", content: [], lazy_load: "lazy-load"}]
  end

  # def hidebanner
  #   if params["hide_type"] == "livestream"
  #     session[:hidden_livestream_id] = Livestream.next_livestream.id
  #     render json: {hidden_id: Livestream.next_livestream.id}
  #   else
  #     session[:hide_application_link] = true
  #     render nothing: true;
  #   end
  # end
end