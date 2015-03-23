class VideoFeature < ActiveRecord::Base
	belongs_to :video

	def self.currently_featured_videos
		where(:type_qwatch => true).limit(5)
	end

	def self.currently_featured_playlists
		where(:type_series => true).limit(3)
	end
end
