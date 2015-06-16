class VideosController < ApplicationController
  # load_and_authorize_resource



  def show
    @video = Video.friendly.find(params[:id])
    @og_title = "DraperTV - #{@video.title}"
    @og_description = @video.description
    @og_image = @video.vthumbnail_url
    @playlist = @video.playlist

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
