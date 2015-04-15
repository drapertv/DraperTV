Challenges =
	init: ->
		$('body').on 'submit', '.challenge-comment-form .new_comment' , @validateChallengeComment

	validateChallengeComment: ->
		noSubmit = false
		$(@).find('input, textarea').each ->
			if $(@).val() == ""
				$(@).css('border', '1px solid red')
				noSubmit = true
			else
				$(@).attr('style', 'none')

		if !$(@).find('#comment_video_url').val().match /[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/
			$(@).find('#comment_video_url').css('border','1px solid red')
			noSubmit = true

		console.log noSubmit
		return false if noSubmit == true


				

		
ready = ->
	Challenges.init()
$(document).ready ready
$(document).on 'page:load', ready


