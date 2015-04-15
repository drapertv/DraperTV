class VideoFeature < ActiveRecord::Base
	belongs_to :video
	delegate :speaker, :profilepic_url, :name, to: :video

	def self.currently_featured_videos tags=nil
		features = where(:type_qwatch => true).limit(5)
		if tags 
			tags = tags.split(",")
			features = features.select do |f|
				list = f.video.category_list
				(list - tags).length < list.length 
			end
		end
		features
	end

	def self.currently_featured_playlists
		where(:type_series => true).limit(3)
	end
end
