# js for site wide UI (headers, footers, modals, buttons etc.) 

GlobalUI =
	init: ->
    # FastClick.attach(document.body)  
    $('body').on 'click', '.search-icon:not(.hide-search)', @showSearchBox
    $('body').on 'click', '.hide-search', @hideSearchBox
    $('body').on 'click', '.show-notify-modal', @showNotifyModal
    $('body').on 'click touchstart', '.modal-container, .modal-container .close', @hideNotifyModal
    $('body').on 'ajax:success', '.notifications-form', @showSubmitConfirmation
    $('body').on 'click', '.disabled', @disableLink
    $('body').on 'click', 'a', @freeze
    document.ontouchmove = @checkScrollable
    @scrollable = true
    if $(window).width() > 768
      $('body').on 'mouseenter', '.action-icon', @showActionIconText
      $('body').on 'mouseleave', '.action-icon', @hideActionIconText
      
    $('body').on 'click', '.header-mobile-menu:not(.close)', @openMobileDropdown
    $('body').on 'click', '.header-mobile-menu.close', @closeMobileDropdown

  freeze: ->
    throw new Error("Frozen");

  checkScrollable: (e) ->
    unless GlobalUI.scrollable
      e.preventDefault()

  openMobileDropdown: ->
    $('.mobile-dropdown').show()
    $(@).hide()
    $('.logo').hide()
    $('.header-mobile-menu.close').show()

  closeMobileDropdown: ->
    $('.mobile-dropdown').hide()
    $('.header-mobile-menu').attr('style', '')
    $('.logo').attr('style', '')
    $(@).hide()
    $('.header-mobile-menu.close').hide()

    # $('.header-content *').attr('style', '')

  showSearchBox: -> 
    $(@).addClass('hide-search')
    if $(window).width() < 768 
      $('.search-input').show().focus()
      $('.logo, .header-mobile-menu').hide()
      return

    $('.header-right .header-item:not(.search-icon)').addClass('animated fadeOut').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $('.header-item:not(.search-icon, .logo)').hide()
      $('.search-input').show().focus()
    

  hideSearchBox: ->
    if $(window).width() < 768
      $('.search-input').hide()
      $('.mobile-logo, .header-mobile-menu:not(.close), .logo').attr('style', '')
      $(@).removeClass('hide-search')
      return
    $('.header-right .header-item:not(.search-icon)').removeClass('animated').removeClass('fadeOut')
    $('.search-input').hide()
    $('.header-item:not(.search-icon, .logo)').attr('stlye', '')
    $(@).removeClass('hide-search')

  showNotifyModal: (e) ->
    e.preventDefault()
    console.log "ntify"
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

  disableLink: (e) ->
    e.preventDefault() if $(window).width() > 640

ready = ->
	GlobalUI.init()
$(document).ready ready
$(document).on 'page:load', ready
