class Search < ActiveRecord::Base
	belongs_to :user

	
	# Results are ordered by title, speaker_name, and description
	# results from each field are ordered by playlist, video, and challenges
	
	def self.search_for terms
		series = Series.all
		videos = Video.all
		livestreams = Livestream.all
		terms = terms.downcase
		results = [:title, :speaker_name, :speaker_position, :description].map do |field|
			[series, videos, livestreams].map do |models|
				search_model_for(models, terms, field)
			end
		end.uniq.flatten
	end



	def self.search_model_for models, terms, field
		terms.gsub!(/[^0-9a-z ]/i, '')
		models.select do |n| 
			if n.send field
				(n.send(field).downcase =~ /#{Regexp.escape(terms)}/ && n.public) 
			else
				nil
			end
		end
	end

end
