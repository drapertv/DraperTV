describe Challenge do 
	before :all do 
		@playlist = create :playlist
		@video = create :video
		@challenge = create :challenge
	end

	it "can access it's first video" do 
		expect(@challenge.first_video).to eq(@video)
	end
end