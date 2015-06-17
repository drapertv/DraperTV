module Extensions
	module Suggestable
		def suggested(category_list)
    		Playlist.tagged_with(category_list, any: true).limit(10)
  		end
	end
end