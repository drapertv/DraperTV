class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

      #aws CF Sginer
      def signed_html5
        parsed_uri = URI.parse(cf_url)
        url = "#{parsed_uri.scheme}://#{parsed_uri.host}#{parsed_uri.path}/#{video_name}"
        signed_url = sign(url)
      end

        # cf_url is http://dSomething.cloudfront.net/path
        # video_name is test.mp4
      def signed_flash
        path = URI.parse(cf_url).path[/\/+(.*)/, 1]
        rtmp_url = "rtmp://someRandomSubDomain.cloudfront.net:1935/cfx/st/mp4:"
        rtmp_path = sign("#{path}/#{video_name}")
        full_url = "#{rtmp_url}#{rtmp_path}"
      end

      def sign(url="")
        # 1 hour expiration on the URL
        url = SIGNER.sign(url.to_s, :ending => Time.now + 3600)
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






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :author_id, :speaker, :description, :url, :value,:thumbnail)
    end
end
