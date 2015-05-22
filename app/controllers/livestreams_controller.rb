class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.friendly.find(params[:id])
    @og_title = "DraperTV - #{@livestream.title}"
    @og_description = @livestream.description
    @og_image = @livestream.image_url
    @commentable = @livestream
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
  end

  def index
    @og_title = "DraperTV - Livestreams"
    @og_description = "Livestreaming the best of Silicon Valley"
    upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    past_livestreams = Livestream.past.order('stream_date desc')
    current_livestreams = Livestream.current
    if !current_livestreams.empty?
      @og_image = current_livestreams.first.image_url
    elsif !upcoming_livestreams.empty?
      @og_image = upcoming_livestreams.first.image_url
    else
      @og_image = past_livestreams.first.image_url
    end
    @livestreams = [{title: "LIVESTREAMING NOW", collection: current_livestreams},
                    {title: "UPCOMING LIVESTREAMS", collection: upcoming_livestreams},
                    {title: "PAST LIVESTREAMS", collection: past_livestreams}]	
  end

  

  private


end