FactoryGirl.define do  factory :email do
    body "MyString"
created_at "2015-10-30 15:06:26"
  end


  factory :challenge do
    playlist_id 1
    sequence(:title) {|n| "Challenge Title t-#{n}" }
    sequence(:description) {|n| "Challenge Description d-#{n}" }
  end

  factory :user do 
  	name "Test User"
  	email "test@example.com"
    password "password"
  end

  factory :video do 
  	sequence(:title) {|n| "Video Title t-#{n}" }
  	sequence(:description) {|n| "Video Description d-#{n}" }
  	url "someurlthing"
  end

  factory :playlist do 
    sequence(:title) {|n| "Playlist Title t-#{n}" }
    author_id 1
    video_ids (1..10).to_a
  end

  factory :speaker do 
    sequence(:name) {|n| "Speaker Name s-#{n}" }
    email "speakeremail@example.com"
    title  "Speaker Title"
  end

  factory :comment do 
  end

  factory :future_livestream, :class => "Livestream" do 
    sequence(:stream_date) {|n| Time.now + (n * 90).minutes } 
  end

  factory :past_livestream, :class => "Livestream" do 
    sequence(:stream_date) {|n| Time.now - (n * 90).minutes } 
  end

  factory :search do 
  end

end

