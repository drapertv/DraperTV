describe Comment do 
	before :all do 
		@video = create :video
		@challenge = create :challenge
	end

	describe "Challenge Comment" do 
		it "can determine that it belongs to a challenge" do 
			comment = @challenge.comments.new(content: "some text")
			comment.save
			expect(comment.belongs_to_challenge?).to eq(true)
		end

		context "when it has a youtube url for video_url attribute" do 	
			it "processes the youtube url into the url_thumbanil attribute and saves url_type as video" do 
				comment = Comment.create video_url: "www.youtube.com/?v=abcde"
				expect(comment.url_thumbnail).to eq("http://img.youtube.com/vi/abcde/default.jpg")
				expect(comment.url_type).to eq("video")
			end
		end

		context "when it has an image url for video_url attribute" do 
			it "saves the image url into the url_thumbnail attribute and saves url_type as image" do 
				comment = Comment.create video_url: "www.pictures.com/picture.jpg"
				expect(comment.url_thumbnail).to eq("www.pictures.com/picture.jpg")
				expect(comment.url_type).to eq("image")
			end
		end


	end

end