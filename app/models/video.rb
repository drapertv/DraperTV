class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :category

	#aws CF Sginer
	def signed_html5
	  parsed_uri = URI.parse(cf_url)
	  url = "#{parsed_uri.scheme}://#{parsed_uri.host}#{parsed_uri.path}/#{video_name}"
	  signed_url = sign(url)
	end

	  # cf_url is http://dSomething.cloudfront.net/path
	  # video_name is test.mp4
	def signed_flash
	  path = URI.parse(cf_url).path[/\/+(.*)/, 1]
	  rtmp_url = "rtmp://someRandomSubDomain.cloudfront.net:1935/cfx/st/mp4:"
	  rtmp_path = sign("#{path}/#{video_name}")
	  full_url = "#{rtmp_url}#{rtmp_path}"
	end

	def sign(url="")
	  # 1 hour expiration on the URL
	  url = SIGNER.sign(url.to_s, :ending => Time.now + 3600)
	end




end
