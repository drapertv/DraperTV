Home =
	init: ->
		$('body').on 'click', '.content-expand-header', @expandContentOnClick
		$('body').on 'click', '.featured-tabs button', @showTabOnClick
		@mobile = $(window).width() < 1024
		$('.home').parents('body').addClass('show-scroll-bar')
		$('body').on 'click', '.close-banner', @closeBanner		  
		# switch between slideshow and carousel appropriately if page width changes
		# polls page for width every half second
		if @mobile
			Home.onMobile = true
		else
			Home.onDesk = true
		setInterval ->
			if $(window).width() < 1024 && Home.onDesk
				Home.initCarouselOnPageLoad() 
				Home.onMobile = true
		, 500
		setInterval ->
			if $(window).width() > 1023 && Home.onMobile && !Home.slideShowStarted
				Home.initSlideShowOnPageLoad() 
				Home.onDesk = true
		, 500

		@initCarouselOnPageLoad() if @mobile
		@initSlideShowOnPageLoad() if !@mobile

	closeBanner: (e) ->
		e.preventDefault()
		$(@).parent('.livestream-banner').addClass('animated flipOutX').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
			$(@).hide()
		$.get('/hidebanner')

	showTabOnClick: ->
		if $('.video-player').length < 1 || Home.mobile
			$('.featured-tabs > button').removeClass('tabs-selected')
			$(@).addClass('tabs-selected')
			$('.content-list').addClass('hide-section')
			$(".#{$(@).attr('data-show')}").toggleClass('hide-section')

	expandContentOnClick: ->
		$(@).parents('.content').find('.content-expand-content').toggle()
		$(@).children('.arrow').toggleClass('rotate180')

	initCarouselOnPageLoad: ->
		$('.featured-carousel.no-desk').slick
			arrow: false
			autoplay: true
			autoplaySpeed: 3000
			speed: 1000
			pauseOnHover: false

	initSlideShowOnPageLoad: ->
		Home.slideShowStarted = true
		#slideshow for main carousel
		#show the third item
		# $($('.featured-carousel-main .featured-item')[2]).show()
		# setInterval ->
		# 	#fade out current item
		# 	toFadeOut = $('.featured-carousel-main .featured-item:visible').first()
		# 	toFadeOut.fadeOut(1000)

		# 	#fade in next item
		# 	toFadeIn = toFadeOut.parent().next().find('.featured-item')
		# 	if toFadeIn.length == 0
		# 		toFadeIn = $('.featured-carousel-main .featured-item').first()
		# 	toFadeIn.fadeIn(1000)
		# , 5000

		#slideshow for side carousel
		#show the first two items
		$('.featured-carousel-side .featured-item:lt(2)').show()
		setInterval ->
			toSlideDown = $('.featured-carousel-side .featured-item:lt(2)')
			toHide = toSlideDown.last()
			toShow = $('.featured-carousel-side .featured-item').last()

			#slidedown first two items
			toSlideDown.animate
				transform: "translateY(180px)"
			, 1000, ->
				$(@).css('transform' , '')
				toHide.hide()

			#bring next item to the top
			toShow.show().css('position', 'absolute').css('top', '-180px')
			toShow.parent().prependTo('.featured-carousel-side').children()

			#bring next item down
			toShow.animate
				top: "0px"
			, 1000, ->
				$(@).css('position', 'relative')
		, 5000
		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


