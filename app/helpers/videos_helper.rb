module VideosHelper
	  include ActsAsTaggableOn::TagsHelper

	  def matched term, text
	  	text.gsub(/(#{term})/i, '<b>\1</b>').html_safe
	  end
end
