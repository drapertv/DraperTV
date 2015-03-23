class Video < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :category, :vfavs, :sfavs
	has_many :comments, :as => :commentable

  mount_uploader :vthumbnail, VthumbnailUploader

  delegate :speaker, :profilepic_url, :name, to: :playlist

	def increment_demand user
		demand_array = [] if demand_array == nil
		update_attributes demand_array: (demand_array + [user.id])
	end

	def demanded_by? user
		demand_array != nil && demand_array.include?(user.id)
	end

	def can_be_accessed_by? user
		user.access_level >= value
	end

	def playlist
		Playlist.where(author_id: author_id).first
	end



# cf_url is http://dSomething.cloudfront.net/path
# video_name is test.mp4

	#aws CF Sginer
	def signed_html5
		cf_url = "http://dc6in7ze09oom.cloudfront.net"
	  parsed_uri = URI.parse(cf_url)
	  url = "#{parsed_uri.scheme}://#{parsed_uri.host}#{parsed_uri.path}/#{title}"
	  signed_url = sign(url)
	end

	  # cf_url is http://dSomething.cloudfront.net/path
	  # video_name is test.mp4
	def signed_flash
		cf_url = self.url
	  path = URI.parse(cf_url).path[/\/+(.*)/, 1]
	  rtmp_url = "rtmp://dc6in7ze09oom.cloudfront.net:1935/cfx/st/mp4:"
	  rtmp_path = sign("#{path}/#{title}")
	  full_url = "#{rtmp_url}#{rtmp_path}"
	end

	def sign(url="")
	  # 1 hour expiration on the URL
 		url = SIGNER.sign(url.to_s, :ending => Time.now + 3600)
 end

	def signed
	  # 1 hour expiration on the URL
 		url = SIGNER.sign("http://dc6in7ze09oom.cloudfront.net/#{title}.mp4", :ending => Time.now + 3600)
 	end





end
