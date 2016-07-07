Video =
	init: ->
		$('body').on 'click' ,'.series-playlist-info-open', @openSeriesPlaylistInfo
		$('body').on 'click' ,'.series-playlist-info-hide', @hideSeriesPlaylistInfo
		@triangleRotation = 0
		# @linkifyLinks()

	openSeriesPlaylistInfo: ->
		if $(window).width() > 640
			$(@).hide()
			$('.series-playlist-info').show()
			$('.series-playlist-info-hide').css('display', 'flex')
			$('.featured-play-btn').css('transform', 'rotate(270deg)')
		else
			Video.triangleRotation += 180
			$('.featured-play-btn').css('transform', "rotate(#{Video.triangleRotation}deg)")
			$('.series-playlist-info').toggleClass('mobile-show')
			$('.series-playlist-info-open').toggleClass('shadow')

	hideSeriesPlaylistInfo: ->
		$('.series-playlist-info-hide, .series-playlist-info').hide()
		$('.featured-play-btn').attr('style', '')
		$('.series-count').show()
		$('.series-playlist-info-open').show()






	# linkifyLinks: ->
	# 	$('.linkify, .linkify p, .linkify div').each ->
	# 		linkifiedText = Video.linkify $(@).html()
	# 		$(@).html linkifiedText
	# 	$('.linkify').removeClass('linkify').addClass('linkified')

	# linkify: (inputText) ->
	# 	replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim
	# 	replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>')
	# 	replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim
	# 	replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>')
	# 	replacePattern3 = /(([a-zA-Z0-9\-\_\.])+@[a-zA-Z\_]+?(\.[a-zA-Z]{2,6})+)/gim
	# 	replacedText = replacedText.replace(replacePattern3, '<a href="mailto:$1">$1</a>')
	# 	replacedText;
		
ready = ->
	Video.init()
$(document).ready ready
# $(document).on 'page:load', ready