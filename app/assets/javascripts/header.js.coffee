Header =
	init: ->
		$('body').on 'click', '.menu', @toggleMenuOnClick
		$('body').on 'click', '.main', @hideMenuOnClick
		$('body').on 'click', '.search', @toggleSearchOnClick
		@mobile = $(window).width() < 1024
		$(document).scroll @adjustShieldOpacity

	adjustShieldOpacity: ->
		$('.shield').css('opacity', $('body').scrollTop() / 60 )


	toggleSearchOnClick: ->
  		$('.menu, .logo, .search-box, header > a').toggle()

 	hideMenuOnClick: ->
  		$('.menu-menu').hide()
  		$('header *').attr('style', '')

 	toggleMenuOnClick: ->
  		$('.menu-menu').toggle()

ready = ->
	Header.init()
$(document).ready ready
$(document).on 'page:load', ready
