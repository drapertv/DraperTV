class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.friendly.find(params[:id])
    
    @og_title = "#{@livestream.title} - DraperTV"
    @og_description = @livestream.description
    @og_image = @livestream.image_url
  end

  def index
    @og_title = "Livestreams - DraperTV "
    @og_description = "Livestreaming the best of Silicon Valley"
    @upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    @past_livestreams = Livestream.past.order('stream_date desc')
    @current_livestreams = Livestream.current
    
    if !@current_livestreams.empty?
      @og_image = @current_livestreams.first.image_url
    elsif !@upcoming_livestreams.empty?
      @og_image = @upcoming_livestreams.first.image_url
    else
      @og_image = @past_livestreams.first.image_url
    end
  end



end