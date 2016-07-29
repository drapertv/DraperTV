BannerUI =
  init: ->
    $('body').on 'click', '.dot', @moveSlide
    $('body').on 'beforeChange', '.featured-items', @adjustDotShading
    BannerUI.slicked = false
    @initCarousel()
    
  initCarousel: ->
    unless BannerUI.slicked
      $('.featured-items').slick
        speed: 700,
        autoplay: true,
        autoplaySpeed: 20000,
        easing: 'swing'
      BannerUI.slicked = true

  moveSlide: ->
    slideNumber = $(@).attr('data-go-to')
    $('.dot').removeClass('active')
    $($('.dot')[slideNumber]).addClass('active')

    $('.featured-items').slick('slickGoTo', slideNumber)
    $('.featured-info').hide()
    $($('.featured-info')[slideNumber]).show().addClass('animated fadeIn')

  adjustDotShading: (event, slick, currentSlide, nextSlide) ->
    $('.dot').removeClass('active')
    currentDot = $(".dot[data-go-to=#{nextSlide}]")
    currentDot.addClass('active')
    
    currentDot.prevAll().each ->
      $(@).removeClass('left').removeClass('right').addClass('left')
    currentDot.nextAll().each ->
      $(@).removeClass('left').removeClass('right').addClass('right')

    $('.featured-info').hide()
    $($('.featured-info')[nextSlide]).show().addClass('animated fadeIn')

ready = ->
  BannerUI.init()

# $(document).ready ready
$(document).on 'ready page:load', ready
