describe Search do 
	
	describe "performing a search with matched results" do 
		
		context "when playlists, videos, and challenges all match the terms on the same field" do 

			before :each do 
				create :speaker
				3.times {create :playlist }
				3.times {create :video}
				3.times {create :challenge}
			end
			
			context "on Title" do

				it "ranks playlists above videos, and videos above challenges," do 
					results = Search.search_for "Title"
					expect(results[0..2].map(&:class).uniq).to eq([Playlist])
					expect(results[3..5].map(&:class).uniq).to eq([Video])
					expect(results[6..8].map(&:class).uniq).to eq([Challenge])
				end
			end

			context "on Speaker Name/Name" do 

				it "ranks playlists above videos, and videos above challenges," do 
					results = Search.search_for "Speaker Name"
					expect(results[0..2].map(&:class).uniq).to eq([Playlist])
					expect(results[3..5].map(&:class).uniq).to eq([Video])
					expect(results[6..8].map(&:class).uniq).to eq([Challenge])
				end
			end

			context "on Description" do 
				it "ranks videos above challenges" do 
					results = Search.search_for "Description"
					expect(results[0..2].map(&:class).uniq).to eq([Video])
					expect(results[3..5].map(&:class).uniq).to eq([Challenge])
				end
			end
		end

		context "when playlists, videos, and challenges match the terms on different fields" do 

			before :each do 
				2.times {create :speaker }
				3.times {create :playlist }
				3.times {create :video}
				3.times {create :challenge}
				matched_speaker = Speaker.last.update_attributes name: "Matched Term"


				@model_with_matched_title = [Playlist, Challenge, Video].sample.first
				@model_with_matched_title.update_attributes title: "Matched Term"

				@model_with_matched_name = Playlist.all.sample
				@model_with_matched_name.update_attributes author_id: 2

				@model_with_matched_description = [Video, Challenge].sample.where('title != (?)', "Matched Term").first
				@model_with_matched_description.update_attributes description: "Matched Term"
				binding.pry
			end

			# it "ranks title, over speaker name, and speaker name over description" do 
			# 	results = Search.search_for "Matched Term"

			# 	expect(results.first).to eq(@model_with_matched_title)
			# 	expect(results[1]).to eq(@model_with_matched_name)
			# 	expect(results[2]).to eq(@model_with_matched_description)
			# end

		end

	end



end