class Search < ActiveRecord::Base
	belongs_to :user

	
	# Results are ordered by title, speaker_name, and description
	# results from each field are ordered by playlist, video, and challenges
	
	def self.search_for terms
		series = Series.all
		videos = Video.all
		livestreams = Livestream.all
		chapters = Chapter.all 
		terms = terms.downcase
		results = [:title, :name, :speaker_title, :description].map do |field|
			[series, videos, livestreams, chapters].map do |models|
				search_model_for(models, terms, field)
			end
		end.uniq.flatten
	end

	private

	def self.search_model_for models, terms, field
		models.select {|n| n.send(field).downcase =~ /#{Regexp.escape(terms)}/ && n.public}
	end

end
