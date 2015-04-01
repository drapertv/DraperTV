class Challenge < ActiveRecord::Base
	acts_as_votable
	belongs_to :playlist
	has_many :comments, :as => :commentable
	delegate :can_be_accessed_by?, :categories, :speaker, :name, :speaker_title, to: :first_video

	def comment_form_path
    	[playlist, self, Comment.new]
  	end

  	def first_video
  		playlist.videos.first
  	end

  	def increment_view_count
		current_view_count = view_count
		update_attributes view_count: view_count + 1
	end

	def publish_date
		created_at.strftime("%B %d, %Y")
	end
end
