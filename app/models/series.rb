class Series < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable_on :category
	delegate :profilepic_url, :name, to: :speaker
  delegate :vthumbnail, to: :first_video
  delegate :vthumbnail_url, to: :first_video
  include Extensions::Publishable



  def self.shown_on_front_page
    order('created_at desc').limit(5)
    limit(5)
  end

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

  def speaker_name 
    speaker.name
  end

  def challenge
    challenges.first
  end

  def speaker_title
    speaker.title
  end

  def thumbnail_title 
    title
  end

  def description
    first_video.description
  end 

  def self.featured
    series = where(show_on_front_page: true)
    series = limit(5) if series.length < 1
    limit(5)
  end

  def self.popular
    where(popular: true).limit(5)
    limit 5
  end

  def self.switch_tags
    ActsAsTaggableOn::Tagging.all.where(taggable_type:"Playlist").update_all taggable_type: "Series"
  end


end
