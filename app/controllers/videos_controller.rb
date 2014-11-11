class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
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
    @video = Video.find(params[:id])
    @commentable = @video
    @comments = @commentable.comments.order('created_at ASC')
    @comment = Comment.new
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






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :author_id, :speaker, :description, :url, :value,:thumbnail, :name,:category_list)
    end
end
