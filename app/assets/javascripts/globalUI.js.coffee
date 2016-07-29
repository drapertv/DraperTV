# js for site wide UI (headers, footers, modals, buttons etc.) 

GlobalUI =
	init: ->
    # FastClick.attach(document.body) #turns all touch events into click events on mobile devices 
    $('body').on 'click', '.disabled', @disableLink

    $('body').on 'click', '.search-icon:not(.hide-search)', @showSearchBox
    $('body').on 'click', '.hide-search', @hideSearchBox
    $('body').on 'click', '.show-notify-modal', @showNotifyModal
    $('body').on 'click touchstart', '.modal-container, .modal-container .close', @hideNotifyModal
    $('body').on 'ajax:success', '.notifications-form', @showSubmitConfirmation
    
    document.ontouchmove = @checkScrollable
    @scrollable = true
    
    $('body').on 'click', '.header-mobile-menu:not(.close)', @openMobileDropdown
    $('body').on 'click', '.header-mobile-menu.close', @closeMobileDropdown
    
    if $(window).width() > 768 #action icons are the series, livestreams, student video, and notify button indicators
      $('body').on 'mouseenter', '.action-icon:not(.expanded)', @showActionIconText
      $('body').on 'mouseleave', '.action-icon:not(.expanded)', @hideActionIconText
      
  checkScrollable: (e) ->
    unless GlobalUI.scrollable
      e.preventDefault()

  openMobileDropdown: ->
    $('.mobile-dropdown').show()
    $(@).hide()
    $('.header-mobile-menu.close').show()

  closeMobileDropdown: ->
    $('header *').attr('style', '')
    # $('.header-mobile-menu').remove()

  showSearchBox: -> 
    $(@).addClass('hide-search')
    if $(window).width() < 768 
      $('.search-input').show().focus()
      $('.logo, .header-mobile-menu').hide()
      return

    $('.search-input').css('position', 'absolute').css('opacity', 0).show().focus()
    $('.header-right .header-item:not(.search-icon)').addClass('animated fadeOut').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $('.header-item:not(.search-icon, .logo)').hide()
      $('.search-input').css('position', 'initial').css('opacity', 1)
    
  hideSearchBox: ->
    if $(window).width() < 768
      $('.search-input').attr('style', '')
      $('.mobile-logo, .header-mobile-menu:not(.close), .logo').attr('style', '')
      $(@).removeClass('hide-search')
      if $('.mobile-dropdown:visible').length > 0
        $('.header-mobile-menu').hide()
        $('.header-mobile-menu.close').show()
      return

    $('.header-right .header-item:not(.search-icon)').removeClass('animated').removeClass('fadeOut')
    $('.search-input').hide()
    $('.header-item:not(.search-icon, .logo)').attr('style', '')
    $(@).removeClass('hide-search')

  showNotifyModal: (e) ->
    e.preventDefault()
    $('html').css('overflow', 'hidden').css('z-index', '-1')
    $('.submit-confirmation').hide()
    $('.hide-on-submit').show()
    $('.modal-container').css('display', 'flex')
    $('#livestream').val($(@).attr('data-livestream-id'))
    GlobalUI.scrollable = false

  hideNotifyModal: (e) ->
    if $(e.target).hasClass('close') || $(e.target).parents('.modal').length < 1
      $('.modal-container').hide() 
      $('html').attr('style', '')
      GlobalUI.scrollable = true

  showSubmitConfirmation: (event, data) ->
    $('.submit-confirmation').show()
    $('.hide-on-submit').css('position', 'absolute').css('opacity', '0')
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
    GlobalUI.iconUnhidable = true
    setTimeout ->
      GlobalUI.iconUnhidable = false
    , 25

  hideActionIconText: ->
    unless GlobalUI.iconUnhidable
      actionIcon = $(@)
      if $(@).hasClass('notify-icon')
        $('.action-icon').removeClass('active').attr('style', '')
        actionIcon.find('p').attr('style', '')
        return
      else
        setTimeout ->
          console.log "hiding"
          unless $('.action-icon.active').length > 1 && actionIcon.hasClass('type-icon')
            $('.action-icon').removeClass('active').attr('style', '') 
            actionIcon.find('p').attr('style', '')
        , 300

  disableLink: (e) ->
    e.preventDefault() if $(window).width() > 640

ready = ->
	GlobalUI.init()
$(document).ready ready
$(document).on 'page:load', ready
