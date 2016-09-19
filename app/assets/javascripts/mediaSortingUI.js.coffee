window.mediaSortingUI = 
  init: ->
    $('body').on 'click', '.sorter', @openDropdown
    $('body, a').on 'click', @closeDropdown
    $('body').on 'click', '.sort-dropdown li', @selectOptionAndSort
    $('body').on 'click', '.order-sort li', @sortOrderByOption
    $('body').on 'click', '.industry-sort li', @sortIndustryByOption
    $('body').on 'change', '.sorter select', @selectOption #the select element is only visible on mobile

  openDropdown: (e) ->
    $('.sort-dropdown').hide()
    if e.toElement.tagName != 'LI' 
      if $(window).width() < 769
        $(@).find('select').focus()
      else
        $(@).find('.sort-dropdown').show()

  closeDropdown: (e) ->
    unless $(e.target).hasClass('sorter') || $(e.target).parents('.sorter').length > 0
      $('.sort-dropdown').hide()

  selectOptionAndSort: (e) ->
    option = $(@).text()
    $('li').removeClass('current')
    $(@).addClass('current')
    $(@).parents('.sorter').find('p').text option
    $(@).parents('.sort-dropdown').hide()

  sortOrderByOption: ->
    option = $(@)
    sorted_by = option.attr('data-sort-criteria')
    order = option.attr('data-sort-direction')
    window.mediaIndexUI.fetchMedia "limit", sorted_by, order, true
  
    if $(window).width() < 641
      window.mediaSortingUI.adjustMobileThumbnailMargins()

  sortAllBySelectedOptions: ->
    window.mediaSortingUI.sortOrderByOption.call($('.order-sort .current'))
    window.mediaSortingUI.sortIndustryByOption.call($('.industry-sort .current'))

  sortIndustryByOption: ->
    option = $(@)
    $('.industry-sort li.current').removeClass('current')
    option.addClass('current')
    $('.media-thumbnails a').hide().show()
    unless option.text() == "All Industries"
      console.log option.text()
      industrySelector = option.text().toLowerCase().replace(' ', '-')
      $('.media-thumbnails a').show()
      $(".media-thumbnail:not(.#{industrySelector})").parent().hide()

    if $(window).width() < 641
      window.mediaSortingUI.adjustMobileThumbnailMargins()

  adjustMobileThumbnailMargins: ->
    $('.media-thumbnails a').css('margin-left', '0px')
    $('.media-thumbnails a').css('margin-right', '0px')
    $('.media-thumbnail').css('margin-left', '0px')
    $('.media-thumbnails a:visible').each (i) ->
      if i % 2 == 1
        $(@).css('margin-left', '1px')

  selectOption: (e) ->
    selector = $(@)
    selected = $(@).val()
    options = $(@).parents('.sorter').find('li')

    # search through the desktop view options and find the one with the matching text
    # call the corresponding sort function passing matching option 
    options.each ->
      $(@).removeClass('current')
      if $(@).text() == selected
        $(@).addClass('current')
        $(@).parents('.sorter').find('p').text selected
        if selector.hasClass('order-select')
          window.mediaSortingUI.sortOrderByOption.call($(@))
        else
          window.mediaSortingUI.sortIndustryByOption.call($(@))

ready = ->
  window.mediaSortingUI.init()

$(document).ready ready
$(document).on 'page:load', ready


