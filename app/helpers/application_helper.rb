module ApplicationHelper
	def display_base_errors resource
		return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
		messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
		html = <<-HTML
		<div class="alert alert-error alert-block">
		<button type="button" class="close" data-dismiss="alert">&#215;</button>
		#{messages}
		</div>
		HTML
		html.html_safe
	end

	def current_admin
		current_user.role == "admin"
	end

	def result_path result
		if result.class == Playlist
			video_path(result.first_video)
		elsif result.class == Video
			video_path(result)
		else
			playlist_challenge_path(result.playlist, result)
		end
	end

	def current_page
		if request.request_uri.include?("videos")
			"videos"
		elsif request.request_uri.include?("playlists")
			"playlists"
		elsif request.request_uri.include?("favorites")
			"favorites"
		else
			""
		end
	end
end
