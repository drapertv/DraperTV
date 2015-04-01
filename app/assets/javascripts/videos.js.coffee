Videos = 
	init: ->
		$('body').on 'click', '.modal-overlay', @hideModal
		$('body').on 'click', '.video-play.blocked', @showVideoModal
		$('body').on 'click', '.video-modal .btn', @thankUser
		$('body').on 'click', '.videos-container .video-header-item', @highlightTag
		$('body').on 'click', '.favorites-header .video-header-item', @highlightVideoType
		$('body').on 'ajax:success', '.fav-link', @updateLikeCount
		@align()

	updateLikeCount: (event, data) ->
		$(@).parent().find('.video-like-count').text(data.like_count)
		$(@).toggleClass('selected')

	highlightVideoType: ->
		$('.favorited-content').hide()
		$('.video-header-item').removeClass 'active'
		$(@).addClass 'active'
		$('.' + $(@).attr('data-show')).show()

	align: ->
		$('.video-item-container').css('margin-right', '10px')
		$('.regular-videos .video-item-container:visible').each (i) ->
			if (i + 1) % 5 == 0
				$(@).css('margin-right', '0px')

	highlightTag: ->
		$(@).toggleClass('active')
		Videos.filterVideos()

	filterVideos: ->
		filters = $('.video-header-item.active p').map (i, v) ->
			return "." + v.className
		filters = $.makeArray(filters).join(", ")
		$('.video-item-container').hide()
		$('.section-content').find(filters).show().addClass('animated fadeIn')
		Videos.align()

	hideModal: (e) ->
		$(@).hide() if $(e.target).hasClass 'modal-overlay'

	showVideoModal: (e) ->
		$(@).parent().find('.modal-overlay').show() if !$(e.target).hasClass 'modal-overlay'

	thankUser: ->
		$(@).parents('.video-modal').find('.modal-message').text("Thanks for your interest, we'll let you know it's available.")
		$(@).hide()

ready = ->
	Videos.init()
$(document).ready ready
$(document).on 'page:load', ready




