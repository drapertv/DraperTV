class StudentVideosController < InheritedResources::Base


  def index
    @og_title = "Student Videos - DraperTV"

    if params[:list] == "true"
      quantity = params[:quantity]
      @student_videos = Video.where(video_type: "student").offset(params[:offset]).order('created_at desc').limit(params[:quantity])
      render partial: "list" and return
    end
  end

end

