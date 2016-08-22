class SlugsController < ApplicationController

	def redirector
		slug = params[:slug]
		
		series = Series.find_by_marketing_slug slug
		redirect_to video_path(series.first_video) and return if series && series.first_video 

		livestream = Livestream.find_by_marketing_slug slug
		redirect_to livestream_path(livestream) and return if livestream

		video = Video.find_by_marketing_slug slug
		redirect_to video_path(video) and return if video

		raise ActionController::RoutingError.new('Not Found')
	end

end