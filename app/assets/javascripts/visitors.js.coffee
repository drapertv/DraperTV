Visitors =
	init: ->
		$('.white-gradient.right').on 'mouseenter', @scrollVideosRight
		$('.white-gradient.left').on 'mouseenter', @scrollVideosLeft
		$('.white-gradient').on 'mouseleave', @stopScrollVideos
		@scrollSpeed = 2
		$('.vbox').removeClass('vbox')
		$('body').on 'ajax:success', '.waitlist-form', @thankUser
		$('body').on 'submit', '.waitlist-form', @checkForm
		$('body').on 'click', '#login', @showLoginModal
		$('body').on 'click', @hideLoginModal
		$('body').on 'submit', '#invite-accept-form', @checkInviteAcceptForm
		$('body').on 'submit', '#login-form', @checkLoginForm
		$('body').on 'keydown', '.invite-email', @verifyEmail
		$('.email-check').show() if $('.invite-email').length > 0 && $('.invite-email').val().match(/.+\@.+\..+/)
		$('body').on 'click', '.welcome-close', @closeWelcome

	closeWelcome: ->
		$('#welcome-container').hide()
		history.pushState("home", "home", "/");

	verifyEmail: ->
		if $('.invite-email').val().match(/.+\@.+\..+/)
			$('.email-check').show()
		else
			$('.email-check').hide()

	showLoginModal: ->
		$("#login-modal").show().addClass('animated fadeInDown')

	hideLoginModal: (e) ->
		if $(e.target).attr('id') != "login-modal-trigger" && $(e.target).parents('#login-modal').length < 1
			$('#login-modal').hide()

	checkInviteAcceptForm: ->
		noName = $('.invite-name').val() == ""
		noEmail = $('.invite-email').val() == ""
		noPasswordConf = $('.invite-password-conf').val() == ""
		noPassword = $('.invite-password').val() == ""

		if noName or noEmail or noPasswordConf or noPassword
			$('.invite-name').css('border' , '1px solid #e1474c') if noName
			$('.invite-email').css('border', '1px solid #e1474c') if noEmail
			$('.invite-password').css('border', '1px solid #e1474c') if noPassword
			$('.invite-password-conf').css('border', '1px solid #e1474c') if noPasswordConf
			$('.submit-invite-accept').addClass('invalid').hide().hide().show()
			$('.missing-field-error').show()
			return false

		if $('.invite-password').val().length < 8
			$('.password-error').show()
			return false


	checkLoginForm: ->
		noEmail = $('.login-email').val() == ""
		noPassword = $('.login-password').val() == ""

		if noEmail or noPassword
			$('.login-password').css('border' , '1px solid #e1474c') if noPassword
			$('.login-email').css('border', '1px solid #e1474c') if noEmail
			$('.login-btn').addClass('invalid').hide().hide().show()
			return false



	checkForm: ->
		noName = $('#name').val() == ""
		noEmail = $('#email').val() == ""

		if noName or noEmail
			$('#name').css('border' , '1px solid #e1474c') if noName
			$('#email').css('border', '1px solid #e1474c') if noEmail
			return false

	thankUser: ->
		$('#waitlist-submit').text("Thank You! We'll be in touch!")
		$('.waitlist-form')[0].reset()
		$('#waitlist-back').css('display', 'block').addClass('animated fadeIn')

	scrollVideosRight: ->
		videoList = $(@).parent().find('.series-videos')
		# show the left scroll gradient/arrow
		$(@).parent().find('.white-gradient.left, .scroll-arrow.left').removeClass('hidden')

		#stop scrolling if already scrolling
		clearInterval Visitors.scrollIntervalId

		Visitors.scrollIntervalId = setInterval ->
			pos = videoList.scrollLeft()
			videoList.scrollLeft(pos + Visitors.scrollSpeed)
		, 5

	scrollVideosLeft: ->
		gradient = $(@)
		div = $(@).parent().find('.series-videos')
		clearInterval Visitors.scrollIntervalId
		Visitors.scrollIntervalId = setInterval ->
			pos = div.scrollLeft()
			gradient.parent().find('.white-gradient.left, .scroll-arrow.left').addClass('hidden') if div.scrollLeft() < 1
			div.scrollLeft(pos - Visitors.scrollSpeed)
		, 5

	stopScrollVideos: (e) ->
		# dont stop scrolling if mousing over the scroll arrow, otherwise stop
		clearInterval Visitors.scrollIntervalId if !$(e.relatedTarget).hasClass('scroll-arrow')

ready = ->
	Visitors.init()
$(document).ready ready
$(document).on 'page:load', ready


