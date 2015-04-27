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
	  		"#{text[0..749]}<span class='show-more'>&nbsp;Show More</span><span class='hidden'> #{text[750..-1]}&nbsp;<span class='show-less'>Show Less</span></span>".html_safe
	  	else
	  		text
	  	end
	  end
end
