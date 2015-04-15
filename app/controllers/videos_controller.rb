class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to root_path and return if !current_user
    @tags = Video.tag_counts_on(:category)
    @page = params[:page].to_i || 1
    @page_next = @page + 1
    @page_back = @page > 1 ? @page - 1 : 1
    @videos = Video.all.paginate(page: params[:page], per_page: 20)
    @last_page = @videos.length < 20
    @first_page = @page < 2
    if params[:tags]
      @filters = params[:tags].gsub(" ", ",")
    else
      @filters = nil
    end
    if request.xhr? 
      @videos = Video.tagged_with @filters, any: true
      render partial: 'filtered_index' and return
    end
  end

  def show
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
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
    end
    @video.increment_view_count
    current_user.save_video_in_view_history @video if current_user
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
