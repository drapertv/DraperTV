class StudentVideosController < InheritedResources::Base


  def index
    @og_title = "Student Videos - DraperTV"

    if params[:list] == "true"
      quantity = params[:quantity]
      if params[:sorted_by]
        @student_videos = Video.where(video_type: "student").offset(params[:offset]).order("#{params[:sorted_by]} #{params[:order]}").limit(params[:quantity])
      else
        @student_videos = Video.where(video_type: "student").offset(params[:offset]).order('created_at desc').limit(params[:quantity])
      end
      render partial: "list" and return
    end
  end

end

