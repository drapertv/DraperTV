Videos = 
	init: ->
		$('body').on 'click', '.modal-overlay', @hideModal
		$('body').on 'click', '.video', @showVideoModal
		$('body').on 'click', '.video-modal .btn', @thankUser

	hideModal: (e) ->
		$(@).hide() if $(e.target).hasClass 'modal-overlay'

	showVideoModal: (e) ->
		$(@).find('.modal-overlay').show() if !$(e.target).hasClass 'modal-overlay'

	thankUser: ->
		$(@).parents('.video-modal').text("Thank you for your interest, we'll let you know when this video is available.")
		.addClass("animated fadeIn")


ready = ->
	Videos.init()
$(document).ready ready
$(document).on 'page:load', ready




