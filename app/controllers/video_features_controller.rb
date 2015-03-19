class VideoFeaturesController < InheritedResources::Base
  load_and_authorize_resource

def index
    @video_features = VideoFeature.all
end

  # GET /video_features/1
  # GET /video_features/1.json
  def show
  	@video_feature = VideoFeature.find(params[:id])
  end

  # GET /video_features/new
  def new
    @video_feature = VideoFeature.new
  end

  # GET /video_features/1/edit
  def edit
  end

  # POST /video_features
  # POST /video_features.json
  def create
    @video_feature = VideoFeature.new(video_feature_params)

    respond_to do |format|
      if @video_feature.save
        format.html { redirect_to @video_feature, notice: 'video_feature was successfully created.' }
        format.json { render :show, status: :created, location: @video_feature }
      else
        format.html { render :new }
        format.json { render json: @video_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_features/1
  # PATCH/PUT /video_features/1.json
  def update
    respond_to do |format|
      if @video_feature.update(video_feature_params)
        format.html { redirect_to @video_feature, notice: 'video_feature was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_feature }
      else
        format.html { render :edit }
        format.json { render json: @video_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_features/1
  # DELETE /video_features/1.json
  def destroy
    @video_feature.destroy
    respond_to do |format|
      format.html { redirect_to video_features_url, notice: 'video_feature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video_feature = VideoFeature.find(params[:id])
    end

    def video_feature_params
      params.require(:video_feature).permit(:video_id, :type_qwatch, :type_series)
    end
end

