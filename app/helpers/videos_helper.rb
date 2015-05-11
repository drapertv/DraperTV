module VideosHelper
	  include ActsAsTaggableOn::TagsHelper

	  def matched term, text
	  	text.gsub(/(#{term})/i, '<b>\1</b>').html_safe
	  end

	  def allow_line_break text
	  	text.gsub("\n", "<br>").html_safe
	  end

	  def expandable_text text
	  	if text.length > 750
	  		"#{text[0..349]}<span class='extra-spaces'>&nbsp;&nbsp;&nbsp;</span><span class='show-more'>Show more...</span><span class='hidden'>#{text[350..-1]}&nbsp;&nbsp;&nbsp;<span class='show-less'>Show less</span></span>".html_safe
	  	else
	  		text
	  	end
	  end
end
