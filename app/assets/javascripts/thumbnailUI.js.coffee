# js for thumbnail animations for speakers, livestreams, students etc.

ThumbnailUI =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail, .course-thumbnail:not(.see-more)', @animateAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail, .course-thumbnail', @undoAnimation
		$('body').on 'mouseenter', '.media-thumbnail.livestream', @animateTitle
		$(window).on 'resize', @adjustLastCourseThumbnail
		@adjustLastCourseThumbnail()

	undoAnimation: ->
		thumbnail = $(@)
		setTimeout ->
				thumbnail.removeClass 'show-description'
				ThumbnailUI.unanimate thumbnail
		, 20

	animateAfterDelay: ->
		# only animate for sizes above mobile
		if $(window).width() > 640
			thumbnail = $(@)
			mediaList = thumbnail.parents '.media-list' 
			# if no thumbnails currently showing description
			if mediaList.find('.media-thumbnail.show-description, .course-thumbnail.show-description').length < 1	
				# animate after delay
				setTimeout ->
					if thumbnail.is ":hover" 
						ThumbnailUI.animate thumbnail 
				, 500
			else
				previouslyEnlargedThumbnail = mediaList.find('.media-thumbnail.show-description, .course-thumbnail.show-description').first()
				# if moving mouse to a adjacent thumbnail in the same row
				if previouslyEnlargedThumbnail.parent().next().children()[0] == thumbnail[0] || previouslyEnlargedThumbnail.parent().prev().children()[0] == thumbnail[0]
					ThumbnailUI.animate thumbnail
				else #moving to a non adjacent thumbnail
					# show description after delay
					setTimeout ->
						if thumbnail.is ":hover"
							ThumbnailUI.animate thumbnail
					, 500

	animateTitle: ->
		title = $(@).find('.media-title')
		title.css('height', 'auto')
		if title.height() > 20
			title.css('height', '16px')
			title.parents('.media-info').animate
				bottom: "30px"
			, 400
		else
			title.css('height', '16px')

	adjustLastCourseThumbnail: ->
		if $(window).width() <= 968 && $(window).width() > 640
			# undo any previous changes
			$('.course-thumbnail').removeClass('see-more')
			$('.link-changed').attr('href', $('.link-changed').attr('link-buffer'))

			# mark last visible thumbnail
			lastCourseThumbnail = $('.course-thumbnail:visible').last()
			lastCourseThumbnail.addClass('see-more')
			
			# change link to redirect to courses site
			link = lastCourseThumbnail.parent()
			link.addClass('link-changed')
			link.attr('link-buffer', link.attr('href'))
			link.attr('href', link.attr('data-see-more'))
		else
			# restore to default
			$('.course-thumbnail').removeClass('see-more')
			$('.link-changed').attr('href', $('.link-changed').attr('link-buffer'))

	animate: (thumbnail) ->
		thumbnail.addClass 'show-description' 

		unless thumbnail.hasClass 'course-thumbnail' 
			height = thumbnail.height()
			scaleAmount = (162 / height)
			#enlarge thumbnail and all child elements
			thumbnail.css 'transform', "scale(#{scaleAmount})" 
			shrinkAmount = 1/ scaleAmount

			#shrink fonts of child elements
			ThumbnailUI.shrinkFonts thumbnail.find("*"), shrinkAmount
			ThumbnailUI.shrinkPaddings thumbnail.find(".thumbnail-description"), shrinkAmount
			thumbnail.find('.thumbnail-description').css('padding')
			#slide out description
			thumbnail.find('.thumbnail-description').animate 
				top: "#{height}px"
			, 400, ->
				thumbnail.find('.thumbnail-description').css("box-shadow", "0px 0px 15px black")

			#adjust margins if animating first or last visible elements in row
			width = thumbnail.width()
			scaledWidth = width * scaleAmount
			widthDifference = (scaledWidth - width) / 2
			thumbnailMargins = parseInt(thumbnail.css('margin-right')) * 2
			
			if thumbnail.hasClass('first-in-row')
				thumbnail.css('margin-left', "#{widthDifference}px").css('margin-right', "-#{widthDifference - thumbnailMargins}px")

			if thumbnail.parent().next().find('.media-thumbnail:visible').length < 1
				thumbnail.css('margin-right', "#{widthDifference}px").css('margin-left', "-#{widthDifference - thumbnailMargins}px")


	shrinkFonts: (collection, shrinkAmount) ->
		collection.each (i) ->
			fontSize = parseInt($(@).css('font-size'))
			shrunkSize = shrinkAmount * fontSize
			$(@).css('font-size', "#{shrunkSize}px")

	shrinkPaddings: (collection, shrinkAmount) ->
		collection.each (i) ->
			paddingVertical = parseInt($(@).css('padding').split("px")[0])
			paddingHorizontal = parseInt($(@).css('padding').split("px")[1])
			
			shrunkPaddingVertical = shrinkAmount * paddingVertical
			shrunkPaddingHorizontal = shrinkAmount * paddingHorizontal
			$(@).css('padding', "#{shrunkPaddingVertical}px #{shrunkPaddingHorizontal}px")

	unanimate: (thumbnail) ->
		thumbnail.attr('style', '')
		thumbnail.find('*').attr('style', '')
		
ready = ->
	ThumbnailUI.init()
$(document).ready ready
$(document).on 'page:load', ready


