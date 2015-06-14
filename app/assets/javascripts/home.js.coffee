Home =
	init: ->
		$('body').on 'click', '.content-expand-header', @expandContent
		$('body').on 'click', '.featured-tabs button', @showTab
		@mobile = $(window).width() < 1024
		@initCarousel() if @mobile
		@initSlideShow() if !@mobile
		@translated = 0


	showTab: ->
		$('.featured-tabs > button').removeClass('tabs-selected')
		$(@).addClass('tabs-selected')
		$('.content-list').addClass('hide-section')
		$(".#{$(@).attr('data-show')}").toggleClass('hide-section')

	expandContent: ->
		$(@).next().toggle()
		$(@).children('.arrow').toggleClass('rotate180')

	initCarousel: ->
		$('.featured-carousel').slick
			arrow: false
			autoplay: true
			autoplaySpeed: 3000
			speed: 1000
			pauseOnHover: false

	initSlideShow: ->
		setInterval -> 
			if !$('.featured-one').hasClass('opaque')
				$('.featured-one').animate
					opacity: 0
				, 1000, ->
					$(@).addClass('opaque')
			else
				$('.featured-one').animate
					opacity: 1
				, 1000, ->
					$(@).removeClass('opaque')

			$('.featured-two, .featured-three').animate 
				transform: "translateY(#{Home.translated + 180}px)"
			, 1000
			Home.translated += 180
		, 3000
						

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


