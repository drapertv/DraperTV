module Extensions
	module Viewable
		def increment_view_count
			current_view_count = view_count
			update_attributes view_count: view_count + 1
		end
	end
end