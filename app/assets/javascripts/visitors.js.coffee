Visitors =
	init: ->
		$('.white-gradient.right').on 'mouseenter', @scrollVideosRight
		$('.white-gradient.left').on 'mouseenter', @scrollVideosLeft
		$('.white-gradient').on 'mouseleave', @stopScrollVideos

	scrollVideosRight: ->
		$('.white-gradient.left, .scroll-arrow.left').removeClass('hidden')
		div = $(@).parent().find('.series-videos')
		clearInterval Visitors.scrollIntervalId
		Visitors.scrollIntervalId = setInterval ->
		    pos = div.scrollLeft()
		    div.scrollLeft(pos + 2)
		, 5

	scrollVideosLeft: ->
		div = $(@).parent().find('.series-videos')
		clearInterval Visitors.scrollIntervalId
		Visitors.scrollIntervalId = setInterval ->
		    pos = div.scrollLeft()
		    $('.white-gradient.left, .scroll-arrow.left').addClass('hidden') if div.scrollLeft() < 1
		    div.scrollLeft(pos - 2)
		, 5

	stopScrollVideos: (e) ->
		console.log e
		clearInterval Visitors.scrollIntervalId if !$(e.relatedTarget).hasClass('scroll-arrow')

ready = ->
	Visitors.init()
$(document).ready ready
$(document).on 'page:load', ready


