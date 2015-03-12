Visitors =
	init: ->
		$('.white-gradient, .scroll-arrow').on 'mouseenter', @scrollVideos
		$('.scroll-arrow, .white-gradient').on 'mouseleave', @stopScrollVideos

	scrollVideos: ->
		div = $(@).parents('.series-content')
		Visitors.scrollIntervalId = setInterval ->
		    pos = div.scrollLeft()
		    div.scrollLeft(pos + 2)
		, 5

	stopScrollVideos: ->
		clearInterval Visitors.scrollIntervalId

ready = ->
	Visitors.init()
$(document).ready ready
$(document).on 'page:load', ready


