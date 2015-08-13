class Video < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :category, :vfavs, :sfavs
	has_many :comments, :as => :commentable

  mount_uploader :vthumbnail, VthumbnailUploader
  extend FriendlyId
  
  friendly_id :title, use: :slugged

  delegate :speaker, :profilepic_url, :name, :challenge, :speaker_title, to: :series

  after_update :expire_cache
  after_create :expire_cache
  after_destroy :expire_cache

  include Extensions::Viewable
  include Extensions::Publishable
  include Extensions::Suggestable

	def order_in_series
		ids = series.video_ids
		"#{(ids.find_index(id) || 0) + 1}/#{ids.length}" 
	end

	def series
		Series.where(author_id: author_id).first || Series.first
	end

	def categories
		category_list.join " "
	end

	def comment_form_path
		[self, Comment.new]
	end

	def time_diff
		Time.now - created_at
	end

	def thumbnail options=nil
		options ? series.videos.first.vthumbnail_url(options) : series.videos.first.vthumbnail_url
	end

	private

	def expire_cache
		ActionController::Base.new.expire_fragment('all_videos')
		ActionController::Base.new.expire_fragment('featured_videos')
		ActionController::Base.new.expire_fragment('all_series')
	end
end
