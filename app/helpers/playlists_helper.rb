module PlaylistsHelper

	def media_path content
		if content.class == Video
      video_path content
    elsif content.class == Series
      video_path content.first_video
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
