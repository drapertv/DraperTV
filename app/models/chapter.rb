#deprecated

class Chapter < ActiveRecord::Base

	def url
		"http://courses.drapertv.com/tracks/#{chapter_uid}"
	end

	def image_url
		Series.tagged_with(topic_name).first.vthumbnail
	end

	def lessons
		lessons_info.split("<br>")
	end

	def title
		name
	end

	def description
		summary
	end

	def speaker_title
		lessons.join("<br>")
	end

	def self.topic_names
		["ATTITUDE", "STARTING UP", "PRODUCT", "SALES", "MARKETING", "FUNDRAISING", "HIRING", "BIZ & FINANCE", "LEGAL"] 
	end

	def self.chapters_for topic_name
		where(topic_name: topic_name.upcase).order(:number)
	end

end