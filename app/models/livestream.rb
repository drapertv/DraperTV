class Livestream < ActiveRecord::Base
  has_many :comments, :as => :commentable
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :speaker_name, :speaker_position, :slug, :stream_date, :src_url, :presence => true
  
  
  after_create :expire_cache
  after_create :limit_slug_to_four_words
  after_create :convert_time_to_utc
  after_update :expire_cache
  before_destroy :expire_cache

  mount_uploader :vthumbnail, VthumbnailUploader

  scope :upcoming, -> { where("stream_date > ?", Time.now).order('stream_date asc') }
  scope :past, -> { where("stream_date < ?", Time.now - 90.minutes).order('stream_date desc') }
  scope :current, -> {where("stream_date > ? and stream_date < ?", Time.now - 90.minutes, Time.now )}

  include Extensions::Suggestable


  def self.shown_on_front_page
    all.limit(5)
  end

  def category
    if !categories.empty?
      categories.first.name
    else
      "No Category"
    end
  end

  def featured_top_info
    formatted_stream_date
  end

  def featured_title
    speaker_name.upcase
  end

  def featured_subtitle 
    speaker_position.upcase
  end

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

  def seconds_elapsed_since_creation
    (Time.now - created_at).floor
  end

  def industries
    (1..10).map {|n| "industry-#{n}"}.sample(3).join(" ")
  end


  def formatted_stream_date
    return "Unknown" if !stream_date
  	pst_stream_date = stream_date - 8.hours
  	pst_current_time = Time.now.utc - 8.hours
  	# if stream date is/was today
    if stream_date - Time.now < 24.hours && stream_date - Time.now > -24.hours && pst_stream_date.day == pst_current_time.day
      if stream_date < Time.now
        elapsed_time
      else
        pst_stream_date.strftime("Today at %l:%M %P PST")
      end
  	# if stream date is within the next 48 hours and tomorrow
    elsif stream_date - Time.now < 48.hours &&  stream_date - Time.now > -24.hours && pst_stream_date.day == pst_current_time.day + 1
  		pst_stream_date.strftime("Tomorrow at %l:%M %P PST")
    # if stream date is within the next 48 hours (and not tomorrow)
  	elsif stream_date - Time.now < 48.hours && stream_date > Time.now
      (stream_date - 8.hours).strftime("%B %-d, at %l:%M%P PST")
    # if stream date is after the next 48 hours
    elsif stream_date - Time.now > 48.hours && stream_date > Time.now
      (stream_date - 8.hours).strftime("%B %-d, at %l:%M%P PST")
    # stream date in the past
    else
  		days_ago = (Time.now - pst_stream_date) / 86400
      if days_ago.floor > 1
        pst_stream_date.strftime("#{days_ago.floor} days ago")
      else
        pst_stream_date.strftime("#{days_ago.floor} day ago")
      end
  	end
    if live? 
      "LIVE NOW"
    end
  end

  def self.live_tomorrow
    start_of_tomorrow = Time.parse((Date.today + 1).to_s).utc - 8.hours 
    end_of_tomorrow = Time.parse((Date.today + 2).to_s).utc - 8.hours
    where('stream_date < (?)', end_of_tomorrow).where('stream_date > (?)', start_of_tomorrow).order('stream_date asc')
  end

  def admin_stream_date
    return "Unknown" if !stream_date
    (stream_date - 8.hours).strftime("%B %-d, at %l:%M%P PST")
  end

  def self.next_livestream_info
    livestream = next_livestream
    return if !next_livestream
    if livestream.stream_date < Time.now
      "#{livestream.title} NOW"
    else
      "#{livestream.title} - #{(livestream.stream_date - 8.hours).strftime("%B %-d, at %l:%M%P PST")}"
    end
  end

  def self.banner_livestream_info
    livestream = next_livestream
    time = nil
    if livestream.stream_date < Time.now
      time = "LIVESTREAM - NOW"
    else
      time = "LIVESTREAM - #{(livestream.stream_date - 8.hours).strftime('%B %-d, %l:%M%P PST')}"
    end
    {livestream: livestream, time: time}
  end

  def self.next_livestream
    Livestream.where('stream_date > (?)', Time.now - 90.minutes).order(:stream_date).first
  end

  def self.closest_to_now
    livestreams = [next_livestream] + Livestream.where('stream_date > (?)', Time.now - 90.minutes).order(:stream_date).limit(4).to_a + Livestream.where('stream_date < (?)', Time.now - 90.minutes).order('stream_date desc').limit(5).to_a
    livestreams.uniq.compact[0..4]
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

  def thumbnail_title
    speaker_position
  end

  def self.seed_speaker_name_and_position
    all.each do |l|
      speaker_name = l.title.split(" - ")[0]
      speaker_position = l.title.split(" - ")[-1]
      l.update_attributes speaker_name: speaker_name, speaker_position: speaker_position
    end
  end

  def self.seed_slugs
    all.each do |livestream|
      slug = nil
      if livestream.speaker_name
        slug = livestream.speaker_name.downcase.gsub(/\W+/, '').gsub(" ", "-") + "-l#{livestream.id}"
      else
        slug = "l-#{livestream.id}"
      end
      livestream.update_attributes slug: slug
    end
  end

  def site_classification
    "Livestream Event"
  end

  def featured_icon
    "livestream-black.png"
  end

  def self.today
    where('stream_date < (?)', Time.now + 24.hours).where('stream_date > (?)', Time.now).select {|n| n.stream_date.day == Time.now.utc.day}
  end

  def formatted_description
    return nil if description.nil?
    description.gsub("\n", "<br>")
  end

  def notify
    if ready_to_notify && !notified

      emails_subscribed_to_all = []
      if LivestreamNotifyList.instance.emails
        emails_subscribed_to_all = Email.find(LivestreamNotifyList.instance.emails).map(&:body)
      end

      emails_subscribed_to_this_item = Email.find(Notification.where(livestream_id: id).pluck(:email_id)).map(&:body)

      emails = (emails_subscribed_to_all + emails_subscribed_to_this_item).uniq
      
      emails.each do |email|
        UserMailer.notification_email(self, email).deliver
      end
      update_attributes notified: true
    end
  end

  def seconds_elapsed_since_creation
    (Time.now - created_at).floor
  end


  def category_name
    categories.pluck(:name).first.gsub(" ", "-").downcase unless categories.empty?
  end

  ransacker :by_categorization, formatter: proc{ |v|

    Category.find_by_name(v).livestreams.pluck :id
    nil if !(Category.find_by_name(v).livestreams.pluck :id)
  } do |parent|
    parent.table[:id]
  end

  def html_description
    description.gsub("\n", "<br>").html_safe if description
  end

  def self.biweekly_latest
    where('stream_date < (?)', Time.now).order('created_at desc').limit(2)
  end

  def self.biweekly_latest_titles
    biweekly_latest.pluck(:title).join(" | ")
  end


  private

  def convert_time_to_utc
    update_attributes stream_date: stream_date + 8.hours
  end

  def expire_cache
    ActionController::Base.new.expire_fragment('all_livestreams')
    ActionController::Base.new.expire_fragment('homepage')
  end

  def limit_slug_to_four_words
    update_attributes slug: slug.split("-")[0..3].join("-")
  end

  def sanitize_description
    binding.pry
    update_attributes body: Sanitize.fragment(description, elements: ["br"])   
  end

end
