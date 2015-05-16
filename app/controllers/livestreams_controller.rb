class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.friendly.find(params[:id])
    @commentable = @livestream
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
  end

  def index
    upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    past_livestreams = Livestream.past.order('stream_date desc')
    current_livestreams = Livestream.current
    @livestreams = [{title: "LIVESTREAMING NOW", collection: current_livestreams},
                    {title: "UPCOMING LIVESTREAMS", collection: upcoming_livestreams},
                    {title: "PAST LIVESTREAMS", collection: past_livestreams}]	
  end

  

  private


end