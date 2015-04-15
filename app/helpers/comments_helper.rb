module CommentsHelper

	def make_url url
		u = URI.parse url
		if !u.scheme
			return "http://" + url
		else
			return url
		end
	end
end
