BannerUI =
  init: ->
    $('body').on 'click', '.dot', @moveSlide
    # $('body').on 'afterChange', @adjustDotShading
    $('body').on 'beforeChange', '.featured-items', @adjustDotShading
    @initCarousel()

  initCarousel: ->
    $('.featured-items').slick()

  moveSlide: ->
    slideNumber = $(@).attr('data-go-to')
    $('.dot').removeClass('active')
    $($('.dot')[slideNumber]).addClass('active')
    
    $('.featured-items').slick('slickGoTo', slideNumber)
    $('.featured-info').hide()
    $($('.featured-info')[slideNumber]).show().addClass('animated fadeIn')

    

    # if $($('.dot')[0]).hasClass('active')
    #   $('.dot').removeClass('left').removeClass('right')
    #   $($('.dot')[1]).addClass('right')
    #   $($('.dot')[2]).addClass('right')
    # else if $($('.dot')[1]).hasClass('active')
    #   $('.dot').removeClass('left').removeClass('right')
    #   $($('.dot')[0]).addClass('left')
    #   $($('.dot')[2]).addClass('right')
    # else
    #   $('.dot').removeClass('left').removeClass('right')
    #   $($('.dot')[0]).addClass('left')
    #   $($('.dot')[1]).addClass('left')

  adjustDotShading: (event, slick, currentSlide, nextSlide) ->
    $('.dot').removeClass('active')
    $(".dot[data-go-to=#{nextSlide}]").addClass('active')

    if $($('.dot')[0]).hasClass('active')
      $('.dot').removeClass('left').removeClass('right')
      $($('.dot')[1]).addClass('right')
      $($('.dot')[2]).addClass('right')
    else if $($('.dot')[1]).hasClass('active')
      $('.dot').removeClass('left').removeClass('right')
      $($('.dot')[0]).addClass('left')
      $($('.dot')[2]).addClass('right')
    else
      $('.dot').removeClass('left').removeClass('right')
      $($('.dot')[0]).addClass('left')
      $($('.dot')[1]).addClass('left')

    $('.featured-info').hide()
    $($('.featured-info')[nextSlide]).show().addClass('animated fadeIn')
    
ready = ->
  BannerUI.init()

$(document).on 'ready page:load', ready




