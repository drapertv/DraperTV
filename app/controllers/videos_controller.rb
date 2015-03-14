class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :increment_demand]
  before_filter :authenticate_user!

  # GET /videos
  # GET /videos.json
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

  # GET /videos/1
  # GET /videos/1.json
  def show
    if !@video.can_be_accessed_by?(current_user)
      redirect_to root_path and return
    end
    @video = Video.find(params[:id])
    @commentable = @video
    @comments = @commentable.comments.order('created_at ASC')
    @comment = Comment.new
    # if @video.video_id
    #   oembed = "http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/" + @video.video_id + '&maxwidth=660' + '&autoplay=1'
    #   puts (Curl::Easy.perform(oembed).body_str)["html"]
    #   @video_vimeo_embed = JSON.parse(Curl::Easy.perform(oembed).body_str)["html"]
    # end

    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=white&theme=light" frameborder="0" allowfullscreen> </iframe>})
    end

  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def increment_demand
    @video.increment_demand(current_user) if !@video.demanded_by?(current_user)
    render nothing: true
  end


  def favIt
    @video = Video.find(params[:id])
    @video.upvote_by current_user
    redirect_to video_path
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_video
    @video = Video.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit(:title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end
end
