Management =
	init: ->
		$('body').on 'submit', '#beta-invite-form', @popuplateUserEmailsInput

	popuplateUserEmailsInput: ->
		$('.enabled').each ->
			$('#user_emails').val($(@).val() + "," + $('#user_emails').val())

ready = ->
	Management.init()
$(document).ready ready
$(document).on 'page:load', ready


