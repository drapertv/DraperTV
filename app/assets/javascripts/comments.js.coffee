Comments =
	init: ->
		$('body').on 'ajax:success', '#main-comment-form #new_comment' , @addComment
		$('body').on 'ajax:success', '.nested-comment-form #new_comment', @addNestedComment
		$('body').on 'click', '.comment-reply', @showReplyForm
		$('body').on 'click', @closeNestedCommentForm
		$('body').on 'click', '.comment-video', @openCommetVideo
		$('body').on 'click', '.comment-video-modal', @closeCommentVideo

	closeCommentVideo: (e) ->
		if $(e.target).attr('id') != "ytplayer"
			$('.comment-video-modal').addClass('hidden')

	openCommetVideo: ->
		$(@).parents('.comment-block').find('.comment-video-modal').removeClass('hidden')

	closeNestedCommentForm: (e) ->
		if !$(e.target).hasClass('comment-input') && !$(e.target).hasClass('comment-reply')
			$('.nested-comment-form').hide()

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


