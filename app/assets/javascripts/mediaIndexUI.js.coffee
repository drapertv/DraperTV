# js for series/livestream index views

mediaIndexUI =
  init: ->
    @windowWidth = $(window).width()
    @fetchMedia()
    @currentlyLoading = false

    if @windowWidth > 640
      $('#load-more').on 'click', @fetchMedia
    else
      $(window).scroll @lazyLoadThumbnails
    
  fetchMedia: ->
    mediaLocation = window.location.pathname
    offset = $('#load-more').attr('offset')
    quantity = mediaIndexUI.mediaBatchQuantity()
    
    $.get "#{mediaLocation}?offset=#{offset}&list=true&quantity=#{quantity}", (data) ->
      $('.media-thumbnails.lazy-load').append(data)
      #update offset
      $('#load-more').attr('offset', $('.lazy-load .media-thumbnail').length)

      mediaIndexUI.currentlyLoading = false
      #if no more to load
      if $(data).find('.media-thumbnail').length < quantity
        $('#load-more').hide()

  lazyLoadThumbnails: ->
    heightOfContentAboveThumbnails = 280
    thumbnailHeight = $('.media-thumbnail').height() + 20

    #loading threshold is around 3rd to last row
    loadingThreshold = Math.ceil(($('.media-thumbnail').length / 2) - 4) * thumbnailHeight # + heightOfContentAboveThumbnails
    if $(window).scrollTop() > loadingThreshold && !mediaIndexUI.currentlyLoading
      mediaIndexUI.currentlyLoading = true 
      mediaIndexUI.fetchMedia()
      
  mediaBatchQuantity: ->
    switch true
      when mediaIndexUI.windowWidth > 1024
        quantityToFetch = 30
      when mediaIndexUI.windowWidth > 824
        quantityToFetch = 48
      when mediaIndexUI.windowWidth > 640
        quantityToFetch = 36
      else
        quantityToFetch = 12

    quantityToFetch


ready = ->
  mediaIndexUI.init()


$(document).ready ready
$(document).on 'page:load', ready
