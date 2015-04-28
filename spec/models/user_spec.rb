describe User do 
	
	before :all do 
		@user = create :user
	end

	describe "watching a video" do 
		it "can save videos to view history" do 
			video_1 = create :video
			video_2 = create :video
			@user.save_video_in_view_history video_1
			@user.save_video_in_view_history video_2
			expect(@user.video_view_list).to eq([video_1.id, video_2.id]) 
		end
	end

	describe "Profile Picture" do
		context "when a profile picture has not been uploaded" do
			it "displays the default picture" do 
				expect(@user.avatar_url).to eq("profile-pic.svg")
			end
		end
	end

end