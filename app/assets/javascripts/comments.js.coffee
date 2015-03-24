Comments =
	init: ->
		$('body').on 'ajax:success', '#new_comment' , @addComment
		$('body').on 'keydown', '#new_comment textarea', @submitComment

	addComment: (event, data) ->
		$('#comments').prepend(data)
		$(@)[0].reset()
		$('.comment').first().addClass('animated fadeIn')

	submitComment: (e) ->
		if e.keyCode == 13
			$(@).parents('form').submit()

ready = ->
	Comments.init()
$(document).ready ready
$(document).on 'page:load', ready


