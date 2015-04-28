module Extensions
	module Publishable
		def publish_date
			created_at.strftime("%B %d, %Y")
		end
	end
end