# js for site wide UI (headers, footers, modals, buttons etc.) 

GlobalUI =
	init: ->
    FastClick.attach(document.body) if $(window).width() < 768
    $('body').on 'click', '.search-icon', @showSearchBox
    $('body').on 'click', '.hide-search', @hideSearchBox
    $('body').on 'click', '.show-notify-modal', @showNotifyModal
    $('body').on 'click', '.modal-container, .modal-container .close', @hideNotifyModal
    $('body').on 'ajax:success', '.notifications-form', @showSubmitConfirmation
    
    if $(window).width() > 768
      $('body').on 'mouseenter', '.action-icon', @showActionIconText
      $('body').on 'mouseleave', '.action-icon', @hideActionIconText
      
    $('body').on 'click', '.header-mobile-menu', @toggleMobileDropdown

  toggleMobileDropdown: ->
    $('.mobile-dropdown').toggle()

  showSearchBox: -> 
    $(@).addClass('hide-search')
    if $(window).width() < 641 
      $('.search-input').show()
      $('.logo, .header-mobile-menu').hide()
      return

    $('.header-right .header-item:not(.search-icon)').addClass('animated fadeOut').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $('.header-item:not(.search-icon, .logo)').hide()
      $('.search-input').show()
    

  hideSearchBox: ->
    if $(window).width() < 641 
      $('.search-input').hide()
      $('.mobile-logo, .header-mobile-menu').show()
      return
    $('.header-right .header-item:not(.search-icon)').removeClass('animated').removeClass('fadeOut')
    $('.search-input').hide()
    $('.header-item:not(.search-icon, .logo)').show()
    $(@).removeClass('hide-search')

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
      $('.action-icon').removeClass('active').attr('style', '')
      actionIcon.find('p').attr('style', '')
      return
    else
      setTimeout ->
        unless $('.action-icon.active').length > 1 && actionIcon.hasClass('type-icon')
          $('.action-icon').removeClass('active').attr('style', '') 
          actionIcon.find('p').attr('style', '')
      , 300

ready = ->
	GlobalUI.init()
$(document).ready ready
$(document).on 'page:load', ready
