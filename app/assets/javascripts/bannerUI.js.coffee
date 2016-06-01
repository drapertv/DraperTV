BannerUI =
  init: ->
    $('body').on 'click', '.dot', @moveSlide
    $('body').on 'afterChange', @adjustDotShading
    $('body').on 'mouseenter', '.action-icon', @showActionIconText
    $('body').on 'mouseleave', '.action-icon', @hideActionIconText
    @initCarousel()

  initCarousel: ->
    $('.featured-items').slick()

  moveSlide: ->
    slideNumber = $(@).attr('data-go-to')
    $('.dot').removeClass('active')
    $(@).addClass('active')
    $('.featured-items').slick('slickGoTo', slideNumber)

    $($('.dot')[1]).removeClass('left').removeClass('right')
    if $('.dot.left').hasClass('active')
      $($('.dot')[1]).addClass('right')
    else if $('.dot.right').hasClass('active')
      $($('.dot')[1]).addClass('left')
    else

  adjustDotShading: (event, slick, currentSlide, nextSlide) ->
    $('.dot').removeClass('active')
    $(".dot[data-go-to=#{currentSlide}]").addClass('active')

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
  BannerUI.init()
$(document).ready ready
$(document).on 'page:load', ready


