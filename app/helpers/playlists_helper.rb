module PlaylistsHelper

	def media_path content
    if content.class == Video && content.video_type == "student"
      student_path student_slug: content.slug
		elsif content.class == Video
      video_path series_slug: content.series.slug, video_slug: content.slug
    elsif content.class == Series
      if content.first_video
        begin
          video_path series_slug: content.slug, video_slug: content.first_video.slug
        rescue
          binding.pry
        end
      else
        video_path series_slug: Series.first.slug, video_slug: Video.first.slug
      end
    else 
      livestream_path content
    end
	end

  def media_list_path media
    content = media.first
    if content.class == Video || content.class == Series
      series_index_path
    else
      livestreams_path
    end
  end
end
