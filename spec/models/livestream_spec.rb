describe Livestream do 
	
	before :all do 

	end

	describe "retrieving future livestreams" do 
		
		context "when there are future livestreams" do

			it "can retrieve the next livestream to be shown" do 
				later_livestream = create :future_livestream
				even_later_livestream = create :future_livestream
				even_even_later_livestream = create :future_livestream
				expect(Livestream.next_livestream).to eq(later_livestream)
			end
		end

		context "when there are only past livestreams that streamed over 90 minutes ago" do 
			it "returns nil when retrieving the next livestream" do 
				create :past_livestream
				expect(Livestream.next_livestream).to be_nil 
			end
		end

		context "when there is a past livestream that streamed less than 90 minutes ago" do 
			it "returns the recent past livestream" do 
				recent_livestream = Livestream.create stream_date: Time.now - 45.minutes
				expect(Livestream.next_livestream).to eq(recent_livestream)
			end
		end

		context "when there are no livestreams" do 
			it "returns nil when retrieving the next livestream" do 
				expect(Livestream.next_livestream).to be_nil 
			end
		end
	end

	describe 'formatting the stream date' do

		before :each do 
			Time.stubs(:now).returns(Time.mktime(2015,4,1))
			@time = Time.mktime(2015,4,1)
		end

		context "for a stream that is today and in the future" do 
			it "shows the correct date info" do 
				livestream = Livestream.create stream_date: @time + 1.hour
				expect(livestream.formatted_stream_date).to eq("Today at  1:00 am PST") 
			end
		end

		context "for a stream that is tomorrow" do 
			it "shows the correct date info" do 
				livestream = Livestream.create stream_date: @time + 25.hours
				expect(livestream.formatted_stream_date).to eq("Tomorrow at  1:00 am PST") 
			end
		end

		context "for a stream that is after tomorrow" do 
			it "shows the correct date info" do 
				livestream = Livestream.create stream_date: @time + 49.hours
				expect(livestream.formatted_stream_date).to eq("April 3, at  1:00 am PST") 
			end
		end
	end

	describe "displaying info for the next livestream" do 

		before :each do 
			Time.stubs(:now).returns(Time.mktime(2015,4,1))
			@time = Time.mktime(2015,4,1)
		end

		context "when the next livestream is streaming" do 
			it "displays the correct info" do 
				current_livestream = Livestream.create stream_date: @time - 45.minutes, title: "Title"
				expect(Livestream.next_livestream_info).to eq("Title NOW")
			end
		end

		context "when the next livestream is over 90 minutes in the future and there is no currently streaming livestream" do 
			it "displays the correct info" do 
				Livestream.create stream_date: @time + 100.minutes, title: "Title"
				expect(Livestream.next_livestream_info).to eq("Title - April 1, at  1:40am PST")
			end
		end

		context "when there is no next livestream" do 
			it "returns nil" do 
				expect(Livestream.next_livestream_info).to be_nil
			end
		end
	end
end








