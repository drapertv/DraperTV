class SpeakersController < InheritedResources::Base
  before_action :set_speaker, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @speaker = Speaker.all
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.new(speaker_params)

    respond_to do |format|
      if @speaker.save
        format.html { redirect_to @speaker, notice: 'Speaker was successfully created.' }
        format.json { render :show, status: :created, location: @speaker }
      else
        format.html { render :new }
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @speaker.destroy
    respond_to do |format|
      format.html { redirect_to speaker_url, notice: 'speaker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_speaker
    @speaker = Speaker.find(params[:id])
  end

  def speaker_params
    params.require(:speaker).permit(:name, :email, :profilepic, :bio)
  end


end

