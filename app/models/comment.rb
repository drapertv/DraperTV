class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_ancestry

  after_create :process_url



  def belongs_to_challenge
  	commentable.class == Challenge
  end

  private

  def process_url
  	if video_url
      if /www\.*youtube\.com\/.*v=([^&$]*)/.match video_url
    		video_id = $1
    		img = "http://img.youtube.com/vi/#{video_id}/default.jpg"
    		update_attributes url_thumbnail: img, url_type: "video"
    	elsif /([a-z\-_0-9\/\:\.]*\.(jpg|jpeg|png|gif))/i.match video_url
    		update_attributes url_thumbnail: img, url_type: "image"
    	else

    	end
    end
  end

end

