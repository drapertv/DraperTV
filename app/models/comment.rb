class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_ancestry

  after_create :process_url

  def belongs_to_challenge
  	commentable.class == Challenge
  end

  def youtube_embed
    yt_id = video_url.split("v=").last
    video_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{yt_id}?autoplay=0&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
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

