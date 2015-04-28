class Video < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :category, :vfavs, :sfavs
	has_many :comments, :as => :commentable

  mount_uploader :vthumbnail, VthumbnailUploader

  delegate :speaker, :profilepic_url, :name, :challenge, :speaker_title, to: :playlist
  include Extensions::Viewable
  include Extensions::Publishable

	def order_in_playlist
		ids = playlist.video_ids
		"#{(ids.find_index(id) || 0) + 1}/#{ids.length}" 
	end

	def demanded_by? user
		demand_array != nil && demand_array.include?(user.id)
	end

	def can_be_accessed_by? user
		user.access_level >= value
	end

	def playlist
		Playlist.where(author_id: author_id).first || Playlist.first
	end

	def suggested
		Video.tagged_with(category_list).limit(10)
	end

	def categories
		category_list.join " "
	end

	def comment_form_path
		[self, Comment.new]
	end
end
