class VideosController < ApplicationController

  def show
    @video = Video.friendly.find(params[:video_slug] || params[:student_slug])
    @series = @video.series
    @videos = @series.videos
    @media = {title: "Similar Videos", content: Series.popular}

    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
    end

    @og_title = "#{@series.title} - DraperTV"
    @og_description = @series.first_video.description
    @og_image = @series.first_video.vthumbnail_url

    if @video.video_type == "student"
      @og_title = "#{@video.title} - DraperTV"
      render "student_videos/show"
    end
  end

  def update_view_counts # called every 24 hours by 3rd party service
    Video.update_all_view_counts
    render json: {updated: true}
  end

  private

  def video_params
    params.require(:video).permit(:view_count, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end
end
