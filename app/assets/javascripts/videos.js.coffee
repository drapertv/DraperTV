Videos = 
	init: ->
		$('body').on 'click', '.modal-overlay', @hideModal
		$('body').on 'click', '.video-play.blocked', @showVideoModal
		$('body').on 'click', '.video-modal .btn', @thankUser
		$('body').on 'click', '.video-header-item', @highlightTag
		@align()

	align: ->
		$('.video-item-container').css('margin-right', '10px')
		$('.regular-videos .video-item-container:visible').each (i) ->
			if (i + 1) % 5 == 0
				$(@).css('margin-right', '0px')

	highlightTag: ->
		$(@).toggleClass('active')
		Videos.filterVideos()

	filterVideos: ->
		filters = $('.video-header-item.active div').map (i, v) ->
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




