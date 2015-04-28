class LivestreamsController < InheritedResources::Base

  def show
    @livestream = Livestream.find(params[:id])
    @commentable = @livestream
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
  end

  def index
  	@livestreams = Livestream.all.order('stream_date asc')
  end

  

  private


end