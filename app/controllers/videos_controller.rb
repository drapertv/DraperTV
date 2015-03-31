class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.email.nil?
      redirect_to profile_edit_path(current_user), notice: "Enter Your Email Please"
    else
      @arr = []
      @tags = Video.tag_counts_on(:category)
      @tags.each do |tag|
        @arr << tag
      end
      if params[:tag]
        @videos = Video.tagged_with(params[:tag])
      else
        @videos = Video.all
      end
    end
  end

  def show
    if !@video.can_be_accessed_by?(current_user)
      redirect_to root_path and return
    end
    @video = Video.find(params[:id])
    @commentable = @video
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
    # if @video.video_id
    #   oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + @video.video_id + '&maxwidth=660' + '&autoplay=1'
    #   puts (Curl::Easy.perform(oembed).body_str)["html"]
    #   @video_vimeo_embed = JSON.parse(Curl::Easy.perform(oembed).body_str)["html"]
    # end

    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=white&theme=light" frameborder="0" allowfullscreen> </iframe>})
    end
    @video.increment_view_count
    current_user.save_video_in_view_history @video
  end

  def increment_demand
    @video.increment_demand(current_user) if !@video.demanded_by?(current_user)
    render nothing: true
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:view_count, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end
end
