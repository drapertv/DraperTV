module PlaylistsHelper

	def series_link browser, series
		if browser.device.mobile? || browser.device.tablet?
			series_path(series)
		else
			video_path(series.first_video)
		end
	end
end
