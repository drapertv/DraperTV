class Livestream < ActiveRecord::Base
  has_many :comments, :as => :commentable

  def comment_form_path
	[self, Comment.new]
  end

end