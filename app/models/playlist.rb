class Playlist < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable_on :category
  has_many :challenges
	delegate :profilepic_url, :name, to: :speaker
  delegate :vthumbnail, to: :first_video
  include Extensions::Publishable

#Method to update the Array field of the playlist
  def video_ids_raw
    self.video_ids.join("\n,") unless self.video_ids.nil?
  end

  def first_video
    videos.first
  end

  def video_ids_raw=(values)
		int_array = values.split(',').collect{|n| n.to_i}
    self.video_ids =  Array.new(int_array)
  end

  def videos
  	Video.where('id in (?)', video_ids)
  end

  def video_count
    videos.count
  end

  def speaker
  	Speaker.find(author_id)
  end

  def challenge
    challenges.first
  end

  def speaker_title
    speaker.title
  end

  def description
    ""
  end 

  def self.front_page
    where(show_on_front_page: true)
  end

  def self.popular
    (Playlist.where(popular: true) + Livestream.where(popular: true))[0..4].shuffle
  end


end
