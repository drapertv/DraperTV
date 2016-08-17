#= require active_admin/base

$(document).ready ->
	if $('.episode-form').length > 0
		seriesID = window.location.pathname.split("/")[3]
		$.get "/series/#{seriesID}/videos_form", (data) ->
			$('.episode-form').append data

	$('body').on 'click', '.add-episode', ->
		$('.video-form:visible').last().next().removeClass('hidden')

	$('body').on 'click', '.delete-button', ->
		$(@).parents('.video-form').remove()

