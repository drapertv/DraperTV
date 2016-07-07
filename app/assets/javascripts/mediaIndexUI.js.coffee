# js for series/livestream index views

window.mediaIndexUI =
  init: ->
    @windowWidth = $(window).width()
    @fetchInitialMedia()
    @currentlyLoading = false
    if @windowWidth > 640
      $('#load-more').on 'click', @fetchMedia
    else
      $(window).scroll @lazyLoadThumbnails


  fetchInitialMedia: ->
    if $('.lazy-load .media-thumbnail').length < 1
      window.mediaIndexUI.fetchMedia()

  markMultilineTitles: ->
    $('.media-title').each ->
      $(@).css('height', 'auto')
      if $(@).height() > 20
        $(@).parents('.media-info').addClass 'multiline'
      $(@).attr('style', '')
    
  fetchMedia: (noLimit) ->
    mediaLocation = window.location.pathname
    offset = $('#load-more').attr('offset')
    quantity = window.mediaIndexUI.mediaBatchQuantity()
    quantity = 100000 if noLimit == "noLimit"
    $.get "#{mediaLocation}?offset=#{offset}&list=true&quantity=#{quantity}", (data) ->
      $('.media-thumbnails.lazy-load').append(data)
      #update offset
      $('#load-more').attr('offset', $('.lazy-load .media-thumbnail').length)

      window.mediaIndexUI.currentlyLoading = false
      #if no more to load
      if $(data).find('.media-thumbnail').length < quantity
        $('#load-more').hide()
        $('.media-container').css('padding-bottom', '0px') if $('#load-more').length > 0

      window.mediaSortingUI.sortAllBySelectedOptions() if $('.livestream').length == 0
      window.mediaIndexUI.markMultilineTitles()

  lazyLoadThumbnails: ->
    heightOfContentAboveThumbnails = 280
    thumbnailHeight = $('.media-thumbnail').height() + 20

    #loading threshold is around 3rd to last row
    loadingThreshold = Math.ceil(($('.media-thumbnail').length / 2) - 4) * thumbnailHeight # + heightOfContentAboveThumbnails
    if $(window).scrollTop() > loadingThreshold && !mediaIndexUI.currentlyLoading
      window.mediaIndexUI.currentlyLoading = true 
      window.mediaIndexUI.fetchMedia()
      
  mediaBatchQuantity: ->
    switch true
      when window.mediaIndexUI.windowWidth > 1024
        quantityToFetch = 30
      when window.mediaIndexUI.windowWidth > 824
        quantityToFetch = 48
      when window.mediaIndexUI.windowWidth > 640
        quantityToFetch = 36
      else
        quantityToFetch = 12

ready = ->
  window.mediaIndexUI.init()


# $(document).ready ready
$(document).on 'ready page:load', ready
