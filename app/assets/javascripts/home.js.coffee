Home =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail', @showDescriptionAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail', @hideDescription

	hideDescription: ->
		thumbnail = $(@)
		setTimeout ->
				thumbnail.removeClass('show-description')
		, 20

	showDescriptionAfterDelay: ->
		thumbnail = $(@)
		mediaList = thumbnail.parents('.media-list')
		if mediaList.find('.media-thumbnail.show-description').length < 1	
			setTimeout ->
				if thumbnail.is(":hover")
					thumbnail.addClass('show-description')
			, 1500
		else
			console.log "added immedietly"
			thumbnail.addClass('show-description')
		

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


