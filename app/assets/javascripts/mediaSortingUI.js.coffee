window.mediaSortingUI = 
  init: ->
    $('body').on 'click', '.sorter', @openDropdown
    $('body').on 'click', @closeDropdown
    $('body').on 'click', '.sort-dropdown li', @selectOptionAndSort
    $('body').on 'click', '.order-sort li', @sortOrderByOption
    $('body').on 'click', '.industry-sort li', @sortIndustryByOption

  openDropdown: (e) ->
    $('.sort-dropdown').hide()
    if e.toElement.tagName != 'LI' 
      $(@).find('.sort-dropdown').show()

  closeDropdown: (e) ->
    unless $(e.target).hasClass('sorter') || $(e.target).parents('.sorter').length > 0
      $('.sort-dropdown').hide()

  selectOptionAndSort: (e) ->
    option = $(@).text()
    $(@).parents('.sorter').find('p').text option
    $(@).parents('.sort-dropdown').hide()

  sortOrderByOption: ->
    option = $(@)

    $('.order-sort li.current').removeClass('current')
    option.addClass('current')
    criteria = option.attr('data-sort-criteria')
    direction = option.attr('data-sort-direction')
    
    $('.media-thumbnails.sortable').each ->
      container = $(@)
      thumbnails = container.find('a')
      sortedThumbnails = window.mediaSortingUI.sortCollection thumbnails, criteria, direction
      $(sortedThumbnails).detach().appendTo(container)

  sortAllBySelectedOptions: ->
    window.mediaSortingUI.sortOrderByOption.call($('.order-sort .current'))
    window.mediaSortingUI.sortIndustryByOption.call($('.industry-sort .current'))

  sortIndustryByOption: ->
    option = $(@)
    $('.industry-sort li.current').removeClass('current')
    option.addClass('current')
    $('.media-thumbnail').hide().show()
    unless option.text() == "All Industries"
      industrySelector = option.text().toLowerCase().replace(' ', '-')
      $('.media-thumbnail').hide().show()
      $(".media-thumbnail:not(.#{industrySelector})").hide()

    if $(window).width() < 641
      window.mediaSortingUI.adjustMobileThumbnailMargins()

  

  sortCollection: (collection, criteria, direction) ->
    collection.sort (a,b) ->
      attributeA = $(a).children()[0].getAttribute("data-#{criteria}")
      attributeB = $(b).children()[0].getAttribute("data-#{criteria}")

      if attributeA > attributeB 
        1
      else if attributeA < attributeB
        -1
      else
        0

    if direction == "asc"
      return collection
    else
      return collection.get().reverse()

  adjustMobileThumbnailMargins: ->
    $('.media-thumbnail').css('margin-left', '0px')
    $('.media-thumbnail:visible').each (i) ->
      if i % 2 == 1
        $(@).css('margin-left', '1px')


ready = ->
  window.mediaSortingUI.init()

$(document).ready ready
$(document).on 'page:load', ready


