Playlist =
	init: ->
		$('body').on 'click', '.section-title-menu', @toggleCategories
		setInterval @changeScrollPercent, 10
		@pageHeight = $('body').height()
		$('body').on 'click', '.scroll-grey, .scroll-green', @scrollPage
		$('body').on 'mousemove', '.scroll-grey, .scroll-green', @moveScrollPercent
		$('body').on 'mouseleave', '.scroll-grey, .scroll-green', @continueChange
		Playlist.stopChanging = false

	continueChange: ->
		Playlist.stopChanging = false

	scrollPage: (e) ->
		percent = ((e.clientY - 110) / 100)
		scrollTop = ($('body').height() - $(window).height()) * percent
		$('body').scrollTop scrollTop 
		Playlist.stopChanging = false

	moveScrollPercent: (e) ->
		percent = (e.clientY - 110)
		Playlist.stopChanging = true
		$('.scroll-percent').text percent + "%"
		$('.scroll-percent').css "bottom", "#{100 - percent}px"

	changeScrollPercent: ->
		if !Playlist.stopChanging 

			currentHeight = $('body').scrollTop() + $(window).height()
			if currentHeight < 190
				barHeight = 0
			else
				barHeight = Math.ceil(((currentHeight) / Playlist.pageHeight) * 100)
			$('.scroll-green').css('height', "#{barHeight}px")
			barHeight = 100 if barHeight > 100
			$('.scroll-percent').text barHeight + "%"
			$('.scroll-percent').css "bottom", "#{100 - barHeight}px"

	toggleCategories: ->
		$('.categories').toggle()




ready = ->
	Playlist.init()
$(document).ready ready
$(document).on 'page:load', ready