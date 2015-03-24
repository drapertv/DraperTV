class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_ancestry

  def belongs_to_challenge
  	commentable.class == Challenge
  end

end

