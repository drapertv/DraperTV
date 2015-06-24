Playlist =
	init: ->
		$('body').on 'click', '.section-title-menu', @toggleCategoriesOnClick
		setInterval @changeScrollPercentOnScroll, 25
		@pageHeight = $('body').height()
		$('body').on 'click', '.scroll-grey, .scroll-green', @scrollPageOnClick
		$('body').on 'mousemove', '.scroll-grey, .scroll-green', @moveScrollPercentOnMouseMove
		$('body').on 'mouseleave', '.scroll-grey, .scroll-green', @continueChangeOnMouseLeave
		@alignContentOnPageLoad()
		Playlist.scrollBarIsPaused = false

	alignContentOnPageLoad: ->
		# fixes the spacing for justify-content: space-between
		$('.content:last-child').each ->
			if $(@).parent().find('.content').length % 3 == 2
				$(@).addClass('last-odd')

	continueChangeOnMouseLeave: ->
		Playlist.scrollBarIsPaused = false

	scrollPageOnClick: (e) ->
		percentOfPageToScroll = ((e.clientY - 110) / 100)
		pixelsToScroll = ($('body').height() - $(window).height()) * percentOfPageToScroll
		$('body').scrollTop pixelsToScroll
		Playlist.scrollBarIsPaused = false

	moveScrollPercentOnMouseMove: (e) ->
		percent = (e.clientY - 110)
		Playlist.scrollBarIsPaused = true
		$('.scroll-percent').text percent + "%"
		$('.scroll-percent').css "bottom", "#{100 - percent - 5}px"

	changeScrollPercentOnScroll: ->
		#don't change if cursor is on the green scroll bar
		if !Playlist.scrollBarIsPaused 
			#amount currently scrolled
			currentHeight = $('body').scrollTop()
			#amount currently scrolled + (the percentage of the page that has been scrolled * window height)
			currentHeight += (currentHeight / (Playlist.pageHeight - $(window).height())) * $(window).height()
			barHeight = Math.ceil(((currentHeight) / Playlist.pageHeight) * 100)
			#change bar UI
			$('.scroll-green').css('height', "#{barHeight}px")
			#account for rounding errors
			barHeight = 100 if barHeight > 100 || (barHeight > 97 && barHeight < 100)
			$('.scroll-percent').text barHeight + "%"
			$('.scroll-percent').css "bottom", "#{100 - barHeight - 5}px"

	toggleCategoriesOnClick: ->
		$('.categories').toggle()

ready = ->
	Playlist.init()
$(document).ready ready
$(document).on 'page:load', ready