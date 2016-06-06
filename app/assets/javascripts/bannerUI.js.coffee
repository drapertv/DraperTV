BannerUI =
  init: ->
    $('body').on 'click', '.dot', @moveSlide
    $('body').on 'afterChange', @adjustDotShading
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
    
ready = ->
  BannerUI.init()
$(document).ready ready
$(document).on 'page:load', ready


