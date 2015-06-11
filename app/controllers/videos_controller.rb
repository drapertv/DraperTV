class VideosController < ApplicationController
  # load_and_authorize_resource

  def index
    @og_title = "DraperTV - Videos"
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
    expire_fragment('featured_videos')
    
    if request.xhr? #if request is from the filter header
      @videos = Video.tagged_with @filters, any: true
      render partial: 'filtered_index' and return
    end
  end

  def show
    @video = Video.find(params[:id])
    @og_title = "DraperTV - #{@video.title}"
    @og_description = @video.description
    @commentable = @video
    @comments = @commentable.comments.where(ancestry: nil).order('created_at ASC')
    @comment = Comment.new
    @playlist = @video.playlist

    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
    end
    @video.increment_view_count
    current_user.save_video_in_view_history @video if current_user
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:view_count, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end
end
