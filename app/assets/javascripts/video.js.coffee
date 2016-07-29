#js for Video show page
Video =
	init: ->
		$('body').on 'click' ,'.series-playlist-info-open', @openSeriesPlaylistInfo
		$('body').on 'click' ,'.series-playlist-info-hide', @hideSeriesPlaylistInfo
		@triangleRotation = 0
		# @linkifyLinks()

	openSeriesPlaylistInfo: ->
		if $(window).width() > 679
			$(@).hide()
			$('.series-playlist-info').show()
			$('.series-playlist-info-hide').addClass('flex')
			$('.featured-play-btn').css('transform', 'rotate(270deg)')
		else
			Video.triangleRotation += 180
			$('.featured-play-btn').css('transform', "rotate(#{Video.triangleRotation}deg)")
			$('.series-playlist-info').toggleClass('mobile-show')
			$('.series-playlist-info-open').toggleClass('shadow')

	hideSeriesPlaylistInfo: ->
		$('.series-playlist-info-hide, .series-playlist-info, .featured-play-btn, .series-count, .series-playlist-info-open').attr('style', '')
		$('.series-playlist-info-hide').removeClass('flex')

ready = ->
	Video.init()
$(document).ready ready
# $(document).on 'page:load', ready
