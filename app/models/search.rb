class Search < ActiveRecord::Base
	belongs_to :user

	def self.search_for terms
		playlists = Playlist.all
		videos = Video.all
		challenges = Challenge.all
		terms = terms.downcase
		results = [:title, :name, :speaker_title, :description].map do |field|
			[playlists, videos, challenges].map do |models|
				search_model_for(models, terms, field)
			end
		end.uniq.flatten
	end

	def self.search_model_for models, terms, field
		models.select {|n| n.send(field).downcase =~ /#{Regexp.escape(terms)}/ }
	end

end
