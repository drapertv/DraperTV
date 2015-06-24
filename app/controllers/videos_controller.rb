class VideosController < ApplicationController
  # load_and_authorize_resource



  def show
    @video = Video.friendly.find(params[:id])
    @og_title = "#{@video.title} - DraperTV"
    @og_description = @video.description
    @playlist = @video.playlist
    @og_image = @playlist.first_video.vthumbnail_url
    @categories = ["Attitude", "Starting Up", "Fundraising", "Product", "Marketing", "Sales", "Hiring", "Finance", "Legal", "Auxiliary"]
    @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "gray"]

    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
    end
    @video.increment_view_count
  end

  private

  def video_params
    params.require(:video).permit(:view_count, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end
end
