# js for series/livestream index views that deals with ajax loading thumbnails

window.mediaIndexUI =
  init: ->
    @windowWidth = $(window).width()
    @currentlyLoading = false
    @fetchInitialMedia()
    
    if @windowWidth > 640 #lazyload for Mobile
      $('#load-more').on 'click', @fetchMedia
    else
      $(window).scroll @lazyLoadThumbnails

  fetchInitialMedia: -> 
    if $('.lazy-load .media-thumbnail').length < 1 && $('.media-thumbnails.wrap').length > 0
      window.mediaIndexUI.fetchMedia()

  markMultilineTitles: ->
    $('.media-title').each ->
      $(@).css('height', 'auto')
      if $(@).height() > 20
        $(@).parents('.media-info').addClass 'multiline'
      $(@).attr('style', '')
    
  fetchMedia: (noLimit, sorted_by, order, refresh) -> #is also called in mediaSortingUI.js.coffee during a order sort
    mediaLocation = window.location.pathname
    offset = $('#load-more').attr('offset')
    quantity = window.mediaIndexUI.mediaBatchQuantity() #depends on page width
    quantity = 100000 if noLimit == "noLimit"
    url = "#{mediaLocation}?list=true"

    #if fetching media after sorting
    if sorted_by? 
      quantity = $('.media-thumbnail').length
      url += "&sorted_by=#{sorted_by}&order=#{order}&offset=0&quantity=#{quantity}"
    else # clicking load more button

      # sort criteria is what is currently selected
      order = $('.sort-dropdown li.current').attr('data-sort-direction')
      sorted_by = $('.sort-dropdown li.current').attr('data-sort-criteria')
      url += "&sorted_by=#{sorted_by}&order=#{order}&offset=#{offset}&quantity=#{quantity}"

    $.get url, (data) ->
      #if loading data after clicking a sort option, content is refreshed
      if refresh? 
        $('.media-thumbnails.lazy-load').html(data)
        $('.media-container').css('padding-bottom', '')
      else   
        $('.media-thumbnails.lazy-load').append(data)

      # show the load more button on page load
      $('#load-more').show() if parseInt($('#load-more').attr('offset')) < 49 
      
      #update offset
      $('#load-more').attr('offset', $('.lazy-load .media-thumbnail').length)

      window.mediaIndexUI.currentlyLoading = false
      #if no more to load
      if $(data).find('.media-thumbnail').length < quantity
        $('#load-more').hide()
        $('.media-container').css('padding-bottom', '0px') if $('#load-more').length > 0

      # window.mediaSortingUI.sortAllBySelectedOptions() if $('.livestream').length == 0
      window.mediaIndexUI.markMultilineTitles()

  lazyLoadThumbnails: ->
    heightOfContentAboveThumbnails = 280
    thumbnailHeight = $('.media-thumbnail').height() + 20
    #loading threshold is around 3rd to last row
    loadingThreshold = Math.ceil(($('.media-thumbnail').length / 2) - 4) * thumbnailHeight # + heightOfContentAboveThumbnails
    if ($(window).scrollTop() > loadingThreshold && !mediaIndexUI.currentlyLoading) && thumbnailHeight > 20
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
