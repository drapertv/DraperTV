class VideoFeature < ActiveRecord::Base
	belongs_to :video

	def self.currently_featured
		where(:type_series => true).limit(5)
	end
end
