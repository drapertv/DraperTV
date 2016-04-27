Home =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail', @showDescriptionAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail', @hideDescription
		$('body').on 'click', '.dot', @moveSlide
		$('body').on 'afterChange', @adjustDotShading
		$('body').on 'click', '.search-icon', @showSearchBox
		$('body').on 'click', '.hide-search', @hideSearchBox
		$('body').on 'mouseenter', '.action-icon', @showActionIconText
		$('body').on 'mouseleave', '.action-icon', @hideActionIconText
		$('body').on 'click', '.show-notify-modal', @showNotifyModal
		$('body').on 'click', '.modal-container, .modal-container .close', @hideNotifyModal
		$('body').on 'ajax:success', '.notifications-form', @showSubmitConfirmation
		@initCarousel()

	hideDescription: ->
		thumbnail = $(@)
		setTimeout ->
				thumbnail.removeClass('show-description')
		, 20

	showDescriptionAfterDelay: ->
		if $(window).width() > 540
			thumbnail = $(@)
			mediaList = thumbnail.parents('.media-list')
			if mediaList.find('.media-thumbnail.show-description').length < 1	
				setTimeout ->
					if thumbnail.is(":hover")
						thumbnail.addClass('show-description')
				, 1500
			else
				console.log "added immedietly"
				thumbnail.addClass('show-description')

	initCarousel: ->
		$('.featured-items').slick()

	moveSlide: ->
		slideNumber = $(@).attr('data-go-to')
		$('.dot').removeClass('active')
		$(@).addClass('active')
		$('.featured-items').slick('slickGoTo', slideNumber)

	adjustDotShading: (event, slick, currentSlide, nextSlide) ->
		$('.dot').removeClass('active')
		$(".dot[data-go-to=#{currentSlide}]").addClass('active')

	showSearchBox: -> 
		$('.header-right .header-item:not(.search-icon)').addClass('animated fadeOut').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
			$('.header-item:not(.search-icon, .logo)').hide()
			$('.search-input').show()
		$(@).addClass('hide-search')

	hideSearchBox: ->
		$('.header-right .header-item:not(.search-icon)').removeClass('animated').removeClass('fadeOut')
		$('.search-input').hide()
		$('.header-item:not(.search-icon, .logo)').show()
		$(@).removeClass('hide-search')

	showActionIconText: ->
		$(@).addClass('active').animate 
			width: $(@).attr('data-width') + "px"
		, 250
		$(@).find('p').animate 
			right: '5%'
		, 250

	hideActionIconText: ->
		actionIcon = $(@)
		if $(@).hasClass('notify-icon')
			$('.action-icon').removeClass('active').attr('style', '')
			return
		else
			setTimeout ->
				console.log "triggered"
				$('.action-icon').removeClass('active').attr('style', '') unless $('.action-icon.active').length > 1 && actionIcon.hasClass('type-icon')
			, 100

	showNotifyModal: (e) ->
		e.preventDefault()
		$('.submit-confirmation').hide()
		$('.hide-on-submit').show()
		$('.modal-container').css('display', 'flex')
		$('#livestream').val($(@).attr('data-livestream-id'))

	hideNotifyModal: (e) ->
		$('.modal-container').hide() if $(e.target).hasClass('close') || $(e.target).parents('.modal').length < 1

	showSubmitConfirmation: (event, data) ->
		$('.submit-confirmation').show()
		$('.hide-on-submit').hide()
		$('.notifications-form')[1].reset()

		

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


