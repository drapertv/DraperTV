Home =
	init: ->
		$('body').on 'click', '.content-expand-header', @expandContent
		$('body').on 'click', '.featured-tabs button', @showTab
		@mobile = $(window).width() < 1024
		@initCarousel() if @mobile


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
						

		
ready = ->
	Home.init()
$(document).ready ready
$(document).on 'page:load', ready


