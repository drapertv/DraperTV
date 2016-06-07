mediaSortingUI = 
  init: ->
    $('body').on 'click', '.sorter', @openDropdown
    $('body').on 'click', '.sort-dropdown li', @selectOptionAndSort

  openDropdown: (e) ->
    if e.toElement.tagName != 'LI' 
      $(@).find('.sort-dropdown').show()

  selectOptionAndSort: (e) ->

    option = $(@).text()
    $(@).parents('.sorter').find('p').text option
    $(@).parents('.sort-dropdown').hide()


ready = ->
  mediaSortingUI.init()


$(document).ready ready
$(document).on 'page:load', ready