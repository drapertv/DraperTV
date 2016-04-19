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
end
