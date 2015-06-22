Header =
	init: ->
		$('body').on 'click, touchend', '.menu-icon', @showMobileDropdown
		$('body').on 'click', '.menu', @toggleMenu
		$('body').on 'click', '.main', @hideMenu
		$('body').on 'click', '.search', @toggleSearch

	toggleSearch: ->
  		$('.menu, .logo, .search-box, header > a').toggle()

 	hideMenu: ->
  		$('.menu-menu').hide()
  		$('header *').attr('style', '')

 	toggleMenu: ->
  		$('.menu-menu').toggle()

ready = ->
	Header.init()
$(document).ready ready
$(document).on 'page:load', ready
