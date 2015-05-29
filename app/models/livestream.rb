class Livestream < ActiveRecord::Base
  has_many :comments, :as => :commentable
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  acts_as_taggable_on :category
  
  after_create :expire_cache
  after_create :limit_slug_to_two_words
  after_update :expire_cache
  before_destroy :expire_cache

  scope :upcoming, -> { where("stream_date > ?", Time.now) }
  scope :past, -> { where("stream_date < ?", Time.now - 90.minutes) }
  scope :current, -> {where("stream_date > ? and stream_date < ?", Time.now - 90.minutes, Time.now )}

  include Extensions::Suggestable

  def comment_form_path
	  [self, Comment.new]
  end

  def formatted_stream_date
  	pst_stream_date = stream_date - 7.hours
  	pst_current_time = Time.now.utc - 7.hours
  	if stream_date - Time.now < 24.hours && pst_stream_date.day == pst_current_time.day
  		pst_stream_date.strftime("Today at %l:%M %P PST")
  	elsif stream_date - Time.now < 48.hours && pst_stream_date.day == pst_current_time.day + 1
  		pst_stream_date.strftime("Tomorrow at %l:%M %P PST")
  	else
  		pst_stream_date.strftime("%B %-d, at %l:%M %P PST")
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

  def self.next_livestream
    Livestream.where('stream_date > (?)', Time.now - 90.minutes).order(:stream_date).first
  end

  def live?
    Time.now - stream_date < 90.minutes && Time.now - stream_date > 0
  end



  private

  def expire_cache
    ActionController::Base.new.expire_fragment('all_livestreams')
  end

  def limit_slug_to_two_words
    update_attributes slug: slug.split("-")[0..1].join("-")
  end

end
