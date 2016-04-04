module PlaylistsHelper

	def media_path content
		if content.class == Video
      video_path content
    else
      livestream_path content
    end
	end
end
