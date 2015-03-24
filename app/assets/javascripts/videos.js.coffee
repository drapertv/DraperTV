Videos = 
	init: ->
		$('body').on 'click', '.modal-overlay', @hideModal
		$('body').on 'click', '.video-play.blocked', @showVideoModal
		$('body').on 'click', '.video-modal .btn', @thankUser

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




