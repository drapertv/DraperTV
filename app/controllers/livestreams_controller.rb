class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.find(params[:id])
    @commentable = @livestream
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
  end

  def index
  	@upcoming_livestreams = Livestream.where('stream_date > (?)', Time.now).order('stream_date asc')
    @past_livestreams = Livestream.where('stream_date < (?)', Time.now).order('stream_date desc')
  end

  

  private


end