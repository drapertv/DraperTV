describe Video do 

	before :each do
		create :playlist
	end

	it "can retrieve order in own playlist" do 
		10.times {create :video}
		video = Video.all.sample
		expect(video.order_in_playlist).to eq("#{video.id}/10")
	end
end