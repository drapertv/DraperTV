class VideoFeature < ActiveRecord::Base
	belongs_to :video
	delegate :speaker, :profilepic_url, :name, to: :video

	after_create :expire_cache
	after_destroy :expire_cache
	after_update :expire_cache

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

	def expire_cache
		ActionController::Base.new.expire_fragment('featured_videos')
		ActionController::Base.new.expire_fragment('featured_playlist')
	end
end
