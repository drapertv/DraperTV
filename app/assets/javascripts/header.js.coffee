Header =
	init: ->
		$('body').on 'click', '.menu', @toggleMenuOnClick
		$('body').on 'click', '.main', @hideMenuOnClick
		$('body').on 'click', '.search', @toggleSearchOnClick
		@mobile = $(window).width() < 1024
		$(document).scroll @freezeHeader if !@mobile
		$(document).scroll @adjustShieldOpacity

	adjustShieldOpacity: ->
		$('.shield').css('opacity', $('body').scrollTop() / 60 )

	freezeHeader: ->
		if $('body').scrollTop() <= 60 && $('#global-header:visible').length < 1
			$('#landing-header, .main').removeClass('freeze')
			$('#global-header').show()
			$('body').scrollTop(59)
		else if $('body').scrollTop() >= 60
			$('#landing-header, .main').addClass('freeze')
			$('#global-header').hide()
		else

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
# $(document).on 'page:load', ready
