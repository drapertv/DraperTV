Home =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail', @showDescriptionAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail', @hideDescription
		$('body').on 'click', '.dot', @moveSlide
		$('body').on 'afterChange', @adjustDotShading
		$('body').on 'click', '.search-icon', @showSearchBox
		@initCarousel()

	hideDescription: ->
		thumbnail = $(@)
		setTimeout ->
				thumbnail.removeClass('show-description')
		, 20

	showDescriptionAfterDelay: ->
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
			$('.search-input').show()


		

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


