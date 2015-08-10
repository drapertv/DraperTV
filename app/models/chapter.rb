class Chapter < ActiveRecord::Base

	def url
		"http://courses.drapertv.com/tracks/#{chapter_uid}"
	end

	def image_url
		Playlist.tagged_with(topic_name).first.vthumbnail
	end

	def lessons
		lessons_info.split("<br>")
	end

	def title
		name
	end

	def description
		topic_name
	end

	def speaker_title
		name
	end

end