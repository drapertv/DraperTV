# js for thumbnail animations for speakers, livestreams, students etc.
ThumbnailUI =
	init: ->
		$('body').on 'mouseenter', '.media-thumbnail, .course-thumbnail:not(.see-more)', @animateAfterDelay
		$('body').on 'mouseleave', '.media-thumbnail, .course-thumbnail', @undoAnimation
		$('body').on 'mouseenter', '.media-thumbnail.livestream', @animateTitle
		$(window).on 'resize', @adjustLastCourseThumbnail
		@markMultilineTitles()
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
				console.log "trig"
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
		#only animate if no other thumbnails are expanded
		if $('.media-thumbnail.show-description, .course-thumbnail.show-description').length < 1	
			title = $(@).find('.media-title')
			#remove height limitation to check title height
			title.css('height', 'auto')
			# if the title is more than 1 line it will be greater than 20px
			if title.height() > 20
				#put height limitation back
				title.css('height', '16px')
				# title.parents('.media-info').animate
				# 	bottom: "26px"
				# , 400, ->
				# 	# title.css('height', 'auto')
					# title.parents('.media-info').css('bottom', '8px')
			else
				title.css('height', '16px')

	markMultilineTitles: ->
		$('.media-title').each ->
			$(@).css('height', 'auto')
			if $(@).height() > 20
				$(@).parents('.media-info').addClass 'multiline'
			$(@).attr('style', '')

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
			width = thumbnail.width()
			scaleAmount = (162 / height)
			#enlarge thumbnail and all child elements
			thumbnail.css 'transform', "scale(#{scaleAmount})" 
			shrinkAmount = 1/ scaleAmount

			#shrink fonts of child elements
			ThumbnailUI.shrinkFonts thumbnail.find("*:not('.action-icon p')"), shrinkAmount
			ThumbnailUI.shrinkPaddings thumbnail.find(".thumbnail-description"), shrinkAmount
			
			#slide out description
			thumbnail.find('.thumbnail-description').animate 
				top: "#{height}px"
			, 400, ->
				thumbnail.find('.thumbnail-description').css("box-shadow", "0px 0px 15px black")
			
			#adjust margins if animating first or last visible elements in row so they don't bleed off the page
			width = thumbnail.width()
			scaledWidth = width * scaleAmount
			widthDifference = (scaledWidth - width) / 2
			thumbnailMargins = parseInt(thumbnail.css('margin-right')) * 2
			
			if thumbnail[0].getBoundingClientRect().left < 100 #if first in row
				thumbnail.css('margin-left', "#{widthDifference}px").css('margin-right', "-#{widthDifference - thumbnailMargins}px")

			if $(window).width() - thumbnail[0].getBoundingClientRect().right < 100 #if last in row
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

	# shrinkDimensions: (collection, shrinkAmount) ->
	# 	collection.each (i) ->
	# 		width = $(@).width()
	# 		height = $(@).height()
	# 		shrunkWidth = shrinkAmount * width
	# 		shrunkHeight = shrinkAmount * height
	# 		$(@).css('width', "#{shrunkWidth}px").attr('data-width', "#{shrunkWidth}px").css('height', "#{shrunkHeight}px")

	unanimate: (thumbnail) ->
		thumbnail.attr('style', '')
		thumbnail.find('*').attr('style', '')
		
ready = ->
	ThumbnailUI.init()
# $(document).ready ready
$(document).on 'ready page:load', ready


