class Challenge < ActiveRecord::Base
	acts_as_votable
	belongs_to :playlist
	has_many :comments, :as => :commentable
	delegate :can_be_accessed_by?, :categories, :speaker, :name, :speaker_title, to: :first_video

	include Extensions::Viewable
	include Extensions::Publishable

	def comment_form_path
    	[playlist, self, Comment.new]
  	end

	def first_video
  		playlist.videos.first
  	end
end
