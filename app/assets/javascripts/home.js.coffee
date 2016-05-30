Home =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail, .course-thumbnail', @showDescriptionAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail, .course-thumbnail', @hideDescription
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
				Home.unscaleThumbnail thumbnail
		, 20

	showDescriptionAfterDelay: ->
		if $(window).width() > 640
			thumbnail = $(@)
			mediaList = thumbnail.parents('.media-list')
			# if no thumbnails currently showing description
			if mediaList.find('.media-thumbnail.show-description, .course-thumbnail.show-description').length < 1	
				# show after delay
				setTimeout ->
					if thumbnail.is(":hover")
						Home.scaleThumbnail thumbnail
				, 500
			else
				previouslyEnlargedThumbnail = mediaList.find('.media-thumbnail.show-description, .course-thumbnail.show-description').first()
				# if moving mouse to a adjacent thumbnail in the same row
				if previouslyEnlargedThumbnail.parent().next().children()[0] == thumbnail[0] || previouslyEnlargedThumbnail.parent().prev().children()[0] == thumbnail[0]
					Home.scaleThumbnail thumbnail
				else #moving to a non adjacent thumbnail
					# show description after delay
					setTimeout ->
						if thumbnail.is(":hover")
							Home.scaleThumbnail thumbnail
					, 500

	scaleThumbnail: (thumbnail) ->
		thumbnail.addClass('show-description')
		height = thumbnail.height()
		scaleAmount = (162 / height)
		#enlarge Thumbnail and all child elements
		thumbnail.css('transform', "scale(#{scaleAmount})")
		shrinkAmount = 1/ scaleAmount

		#shrink fonts of child elements
		Home.shrinkFontsOfCollection thumbnail.find("*"), shrinkAmount
		Home.shrinkPaddingOfCollection thumbnail.find(".thumbnail-description"), shrinkAmount
		thumbnail.find('.thumbnail-description').css('padding')
		#animate description sliding out
		thumbnail.find('.thumbnail-description').animate 
			top: "#{height}px"
		, 400, ->
			thumbnail.find('.thumbnail-description').css("box-shadow", "0px 0px 15px black")


	shrinkFontsOfCollection: (elements, shrinkAmount) ->
		elements.each (i) ->
			fontSize = parseInt($(@).css('font-size').split("px"))
			shrunkSize = shrinkAmount * fontSize
			$(@).css('font-size', "#{shrunkSize}px")

	shrinkPaddingOfCollection: (elements, shrinkAmount) ->
		elements.each (i) ->
			paddingVertical = parseInt($(@).css('padding').split("px")[0])
			paddingHorizontal = parseInt($(@).css('padding').split("px")[1])
			
			shrunkPaddingVertical = shrinkAmount * paddingVertical
			shrunkPaddingHorizontal = shrinkAmount * paddingHorizontal
			$(@).css('padding', "#{shrunkPaddingVertical}px #{shrunkPaddingHorizontal}px")

	unscaleThumbnail: (thumbnail) ->
		thumbnail.attr('style', '')
		thumbnail.find('*').attr('style', '')

	initCarousel: ->
		$('.featured-items').slick()

	moveSlide: ->
		slideNumber = $(@).attr('data-go-to')
		$('.dot').removeClass('active')
		$(@).addClass('active')
		$('.featured-items').slick('slickGoTo', slideNumber)

		$($('.dot')[1]).removeClass('left').removeClass('right')
		if $('.dot.left').hasClass('active')
			$($('.dot')[1]).addClass('right')
		else if $('.dot.right').hasClass('active')
			$($('.dot')[1]).addClass('left')
		else

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
		$(@).find('p').animate 
			opacity: "1"
		, 100

	hideActionIconText: ->
		actionIcon = $(@)
		if $(@).hasClass('notify-icon')
			console.log "this"
			$('.action-icon').removeClass('active').attr('style', '')
			actionIcon.find('p').attr('style', '')
			return
		else
			setTimeout ->
				unless $('.action-icon.active').length > 1 && actionIcon.hasClass('type-icon')
					$('.action-icon').removeClass('active').attr('style', '') 
					actionIcon.find('p').attr('style', '')
			, 300

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


