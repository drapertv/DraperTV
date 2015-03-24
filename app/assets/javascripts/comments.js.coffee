Comments =
	init: ->
		$('body').on 'ajax:success', '#main-comment-form #new_comment' , @addComment
		$('body').on 'ajax:success', '.nested-comment-form #new_comment', @addNestedComment
		$('body').on 'keydown', '#new_comment textarea', @submitComment
		$('body').on 'click', '.comment-reply', @showReplyForm

	showReplyForm: ->
		$(@).parents('.comment-block').find('.nested-comment-form').toggle()

	addNestedComment: (event, data) ->
		parentComment = $(@).parents('.comment-block')
		parentComment.find('.nested-comments').prepend(data)
		parentComment.find('.nested-comments').find('.comment').first().addClass('animated fadeIn')
		parentComment.find('.nested-comment-form').hide()
		@.reset()
		

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


