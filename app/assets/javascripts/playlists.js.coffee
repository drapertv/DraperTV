Playlist =
	init: ->
		$('body').on 'click', '.section-title-menu', @toggleCategoriesOnClick
		setInterval @changeScrollPercentOnScroll, 25
		@pageHeight = $('body').height()
		$('body').on 'click', '.scroll-grey, .scroll-green', @scrollPageOnClick
		$('body').on 'mousemove', '.scroll-grey, .scroll-green', @moveScrollPercentOnMouseMove
		$('body').on 'mouseleave', '.scroll-grey, .scroll-green', @continueChangeOnMouseLeave
		Playlist.scrollBarIsPaused = false
		@linkifyLinks()

	linkifyLinks: ->
		$('.linkify, .linkify p, .linkify div').each ->
			linkifiedText = Playlist.linkify $(@).html()
			$(@).html linkifiedText
		$('.linkify').removeClass('linkify').addClass('linkified')

	linkify: (inputText) ->
		replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim
		replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>')
		replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim
		replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>')
		replacePattern3 = /(([a-zA-Z0-9\-\_\.])+@[a-zA-Z\_]+?(\.[a-zA-Z]{2,6})+)/gim
		replacedText = replacedText.replace(replacePattern3, '<a href="mailto:$1">$1</a>')
		replacedText;
		

	continueChangeOnMouseLeave: ->
		Playlist.scrollBarIsPaused = false

	scrollPageOnClick: (e) ->
		percentOfPageToScroll = ((e.clientY - 170) / 100)
		pixelsToScroll = ($('body').height() - $(window).height()) * percentOfPageToScroll
		$('body').scrollTop pixelsToScroll
		Playlist.scrollBarIsPaused = false

	moveScrollPercentOnMouseMove: (e) ->
		percent = (e.clientY - 170)
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