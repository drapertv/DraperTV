module PlaylistsHelper

	def playlist_link browser, playlist
		if browser.mobile?
			playlist_path(playlist)
		else
			video_path(playlist.first_video)
		end
	end
end
