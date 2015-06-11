Header =
	init: ->
		$('body').on 'click, touchend', @restoreHeader
		$('body').on 'click, touchend', '.menu-icon', @showMobileDropdown
		$('body').on 'click, touchend', '.visitor-login', @showVisitorLogin
		$('body').on 'click', '#login', @showLoginModal
		$('body').on 'click', @hideLoginModal
		$('body').on 'click', '.menu', @toggleMenu
		$('body').on 'click', '.main', @hideMenu
		$('body').on 'click', '.search', @toggleSearch

	toggleSearch: ->
  		$('.menu, .logo, .search-box').toggle()

 	hideMenu: ->
  		$('.menu-menu').hide()

 	toggleMenu: ->
  		$('.menu-menu').toggle()

	restoreHeader: (e) ->
		if $(e.target).attr('id') != 'landing-header' && $(e.target).parents('#landing-header').length < 1
			$('.header-mid-left, .header-dropdown').addClass('no-mobile')
			$('#landing-header *').attr('style', '')

	showVisitorLogin: ->
		$('.visitor-dropdown-item, .dropdown-signup').hide()
		$('#login-form').show().addClass('animated fadeIn')
		$('.header-dropdown').animate 
				height: "190px"
			, 300

	showMobileDropdown: ->
		$('#landing-header').css('border', 'none')
		$('#login-form').hide()
		$('.header-dropdown').attr('style', '')
		if $('.header-dropdown:visible').length < 1
			$('.header-dropdown').removeClass('no-mobile')
			$('.header-dropdown').animate 
				height: "120px"
			, 300
			$('.visitor-dropdown-item').show().addClass('animated fadeIn')
		else
			$('.header-dropdown').attr('style', '').addClass('no-mobile')
			$('#landing-header').attr('style', '')
			$('.visitor-dropdown-item').hide()

	showLoginModal: ->
		$("#login-modal").show().addClass('animated fadeInDown').find('input').first().focus()

	hideLoginModal: (e) ->
		if $(e.target).attr('class') != "login-modal-trigger" && $(e.target).parents('#login-modal, #new_comment, .livestream-text').length < 1
			$('#login-modal').hide()


ready = ->
	Header.init()
$(document).ready ready
$(document).on 'page:load', ready