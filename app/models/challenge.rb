class Challenge < ActiveRecord::Base
	belongs_to :playlist
	has_many :comments, :as => :commentable

	def comment_form_path
    	[playlist, self, Comment.new]
  	end
end
