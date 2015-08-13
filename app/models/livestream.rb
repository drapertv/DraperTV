class Livestream < ActiveRecord::Base
  has_many :comments, :as => :commentable
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  acts_as_taggable_on :category
  
  after_create :expire_cache
  after_create :limit_slug_to_two_words
  after_update :expire_cache
  before_destroy :expire_cache

  mount_uploader :vthumbnail, VthumbnailUploader

  scope :upcoming, -> { where("stream_date > ?", Time.now) }
  scope :past, -> { where("stream_date < ?", Time.now - 90.minutes) }
  scope :current, -> {where("stream_date > ? and stream_date < ?", Time.now - 90.minutes, Time.now )}

  include Extensions::Suggestable

  def comment_form_path
	  [self, Comment.new]
  end

  def elapsed_time
    elapsed_time_in_minutes = (Time.now - stream_date) / 60
    stamp = nil
    if elapsed_time_in_minutes.floor < 60
      stamp = "#{elapsed_time_in_minutes.floor} minutes ago"
    elsif elapsed_time_in_minutes < 1440
      elapsed_time_in_hours = (elapsed_time_in_minutes / 60).floor
      stamp = "#{elapsed_time_in_hours} hours ago"
    else
      stamp = "#{stream_date.strftime("%b %-d")}"
    end
  end

  def formatted_stream_date
  	pst_stream_date = stream_date - 7.hours
  	pst_current_time = Time.now.utc - 7.hours
  	if stream_date - Time.now < 24.hours && pst_stream_date.day == pst_current_time.day
      if stream_date < Time.now
        elapsed_time
      else
        pst_stream_date.strftime("Today at %l:%M %P PST")
      end
  	elsif stream_date - Time.now < 48.hours && pst_stream_date.day == pst_current_time.day + 1
  		pst_stream_date.strftime("Tomorrow at %l:%M %P PST")
  	elsif stream_date - Time.now < 48.hours && stream_date > Time.now
      (stream_date - 7.hours).strftime("%B %-d, at %l:%M%P PST")
    elsif stream_date - Time.now > 48.hours && stream_date > Time.now
      (stream_date - 7.hours).strftime("%B %-d, at %l:%M%P PST")
    else
  		days_ago = (Time.now - pst_stream_date) / 86400
      if days_ago.floor > 1
        pst_stream_date.strftime("#{days_ago.floor} days ago")
      else
        pst_stream_date.strftime("#{days_ago.floor} day ago")
      end
  	end
  end

  def self.next_livestream_info
    livestream = next_livestream
    return if !next_livestream
    if livestream.stream_date < Time.now
      "#{livestream.title} NOW"
    else
      "#{livestream.title} - #{(livestream.stream_date - 7.hours).strftime("%B %-d, at %l:%M%P PST")}"
    end
  end

  def self.banner_livestream_info
    livestream = next_livestream
    time = nil
    if livestream.stream_date < Time.now
      time = "Livestream - NOW"
    else
      time = "Livestream - #{(livestream.stream_date - 7.hours).strftime('%B %-d, %l:%M%P PST')}"
    end
    {livestream: livestream, time: time}
  end

  def self.next_livestream
    Livestream.where('stream_date > (?)', Time.now - 90.minutes).order(:stream_date).first
  end

  def live?
    Time.now - stream_date < 90.minutes && Time.now - stream_date > 0
  end

  def upcoming?
    stream_date - Time.now > 0
  end

  def related_playlists
    Playlist.all.limit(5)
  end

  def name
    title
  end

  def speaker_title
    title
  end

  def self.today
    where('stream_date < (?)', Time.now + 24.hours).where('stream_date > (?)', Time.now).select {|n| n.stream_date.day == Time.now.utc.day}
  end

  private

  def expire_cache
    ActionController::Base.new.expire_fragment('all_livestreams')
  end

  def limit_slug_to_two_words
    update_attributes slug: slug.split("-")[0..1].join("-")
  end

end
