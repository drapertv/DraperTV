FactoryGirl.define do
  factory :challenge do
    playlist_id 1
    description "Challenge Description"
    title "Challenge Title"
  end

  factory :user do 
  	name "Test User"
  	email "test@example.com"
    password "password"
  end

  factory :video do 
  	title "Video Title"
  	description "Video Description"
  	url "someurlthing"
  end

  factory :playlist do 
    title "Playlist Title"
    author_id 1
    video_ids [1,2,3]
  end

  factory :speaker do 
    name "Speaker Name"
    email "speakeremail@example.com"
    title  "Speaker Title"
  end
end

