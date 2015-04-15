class ChallengesController < InheritedResources::Base

  def show
    @playlist = Playlist.find params[:playlist_id]
    @video = @playlist.videos.first
    @challenge = Challenge.find params[:id]
    @commentable = @challenge
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
    if @challenge.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@challenge.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark" frameborder="0" allowfullscreen> </iframe>})
    end
    @challenge.increment_view_count
  end

  private

  def challenge_params
    params.require(:challenge).permit(:view_count)
  end
end

