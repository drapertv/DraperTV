class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :category



	has_many :comments, :as => :commentable



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
