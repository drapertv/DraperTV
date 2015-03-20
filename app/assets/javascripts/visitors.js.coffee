Visitors =
	init: ->
		$('.white-gradient.right').on 'mouseenter', @scrollVideosRight
		$('.white-gradient.left').on 'mouseenter', @scrollVideosLeft
		$('.white-gradient').on 'mouseleave', @stopScrollVideos
		@scrollSpeed = 2 
		$('.vbox').removeClass('vbox')

	scrollVideosRight: ->
		videoList = $(@).parent().find('.series-videos')
		# show the left scroll gradient/arrow
		$(@).parent().find('.white-gradient.left, .scroll-arrow.left').removeClass('hidden')
		
		#stop scrolling if already scrolling
		clearInterval Visitors.scrollIntervalId

		Visitors.scrollIntervalId = setInterval ->
			pos = videoList.scrollLeft()
			videoList.scrollLeft(pos + Visitors.scrollSpeed)
		, 5

	scrollVideosLeft: ->
		gradient = $(@)
		div = $(@).parent().find('.series-videos')
		clearInterval Visitors.scrollIntervalId
		Visitors.scrollIntervalId = setInterval ->
			pos = div.scrollLeft()
			gradient.parent().find('.white-gradient.left, .scroll-arrow.left').addClass('hidden') if div.scrollLeft() < 1
			div.scrollLeft(pos - Visitors.scrollSpeed)
		, 5

	stopScrollVideos: (e) ->
		# dont stop scrolling if mousing over the scroll arrow, otherwise stop
		clearInterval Visitors.scrollIntervalId if !$(e.relatedTarget).hasClass('scroll-arrow')

ready = ->
	Visitors.init()
$(document).ready ready
$(document).on 'page:load', ready


