class SlugsController < ApplicationController

	def redirector
		slug = params[:slug]
		
		series = Series.where(marketing_slug: slug).order('updated_at desc').limit(1)[0]
		redirect_to video_path(series_slug: series.slug, video_slug: series.first_video.slug) and return if series && series.first_video 

		livestream = Series.where(marketing_slug: slug).order('updated_at desc').limit(1)[0]
		redirect_to livestream_path(livestream) and return if livestream

		video = Series.where(marketing_slug: slug).order('updated_at desc').limit(1)[0]
		redirect_to student_path(student_slug: video.slug) and return if video

		raise ActionController::RoutingError.new('Not Found')
	end

end