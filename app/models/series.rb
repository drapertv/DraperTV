class Series < ActiveRecord::Base
  acts_as_votable
	delegate :profilepic_url, :name, to: :speaker


  after_create :check_if_ready_to_notify
  after_create :populate_video_speaker_fields
  after_save :populate_video_speaker_fields
  after_update :check_if_ready_to_notify
  include Extensions::Publishable
  has_many :categorizations
  has_many :categories, through: :categorizations

  mount_uploader :vthumbnail, VthumbnailUploader

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
  	found_videos = Video.where('id in (?)', video_ids)
    if found_videos.first.order
      return found_videos.order(:order)
    else
      return found_videos
    end
  end

  def video_count
    videos.count
  end

  def speaker
  	Speaker.find(author_id)
  end

  def speaker_title
    speaker_position
  end

  def thumbnail_title 
    title
  end

  def site_classification
    "Speaker Series"
  end

  def featured_icon
    "speaker-white.png"
  end

  def self.featured
    front_page_media = nil
    manually_selected_to_front_page = Series.where(show_on_front_page: true).to_a + Livestream.where(show_on_front_page: true).to_a 
    
    if manually_selected_to_front_page.count < 3
      featured_series = Series.order('created_at desc').limit(2).to_a
      featured_livestream = Livestream.next_livestream
      if !featured_livestream
        featured_livestream = [Livestream.last]
      end
      auto_populated_featured_media = featured_series + featured_livestream
      front_page_media = (manually_selected_to_front_page + auto_populated_featured_media)[0..2]
    else
      front_page_media = manually_selected_to_front_page
    end
    front_page_media
  end

  def self.featured_to_edit #for editing in the admin panel
    manually_selected_to_front_page = Series.order(:id).where(show_on_front_page: true).to_a + Livestream.where(show_on_front_page: true).to_a 
    manually_selected_to_front_page += [nil, nil, nil]
    manually_selected_to_front_page[0..2]
  end

  def self.update_featured slugs
    Series.update_all show_on_front_page: false
    Livestream.update_all show_on_front_page: false
    slugs.each do |slug|
      media = Series.where slug: slug
      unless media.empty?
        media.first.update_attributes show_on_front_page: true
      end
      media = Livestream.where slug: slug
      unless media.empty?
        media.first.update_attributes show_on_front_page: true
      end
    end
  end

  def featured_top_info
    "#{name}, #{speaker_title}"
  end

  def featured_title
    title.upcase
  end

  def featured_subtitle
    nil
  end

  def self.popular
    (Series.where(popular: true) + order('view_count desc').limit(5))[0..4]
  end

  def self.popular_to_edit
    manually_selected_to_front_page = Series.order(:id).where(popular: true).to_a
    manually_selected_to_front_page += [nil, nil, nil, nil, nil]
    manually_selected_to_front_page[0..4]
  end

  def self.update_popular slugs
    Series.update_all popular: false
    slugs.each do |slug|
      media = Series.where slug: slug
      unless media.empty?
        media.first.update_attributes popular: true
      end
    end
  end

  def self.get_view_counts_from_videos
    Series.all.each do |series|
      view_count = series.videos.pluck(:view_count).inject(:+)
      series.update_attributes view_count: view_count
    end
  end

  def self.newest
    order('created_at desc').limit(5)
  end

  def self.switch_tags
    ActsAsTaggableOn::Tagging.all.where(taggable_type:"Playlist").update_all taggable_type: "Series"
  end

  def seconds_elapsed_since_creation
    (Time.now - created_at).floor
  end

  def industries
    (1..10).map {|n| "industry-#{n}"}.sample(3).join(" ")
  end

  def self.populate_slugs
    all.each do |series|
      slug = series.speaker_name.downcase.gsub(/\W+/, '').gsub(" ", "-")
      series.update_attributes slug: slug
    end
  end

  ransacker :by_categorization, formatter: proc{ |v|
    Category.find_by_name(v).series.pluck :id 
    nil if !(Category.find_by_name(v).series.pluck :id)
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_episode_title, formatter: proc{ |v|
    ids = Search.search_model_for(Video.all, v, :title).map(&:series).uniq.map(&:id)
    ids == [] ? nil : ids
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_episode_slug, formatter: proc{ |v|
    ids = Search.search_model_for(Video.all, v, :slug).map(&:series).uniq.map(&:id)
    ids == [] ? nil : ids
  } do |parent|
    parent.table[:id]
  end


  def category
    categories.first ? categories.first.name : "No Category"
  end


  private

  def check_if_ready_to_notify 
    if ready_to_notify && !notified
      emails = Email.find(SeriesNotifyList.instance.emails).map(&:body)
      emails.each do |email|
        UserMailer.notification_email(self, email).deliver
      end
      update_attributes notified: true
    end
  end

  def populate_video_speaker_fields
    unless videos.empty?
      videos.each do |video|
        video.update_attributes speaker: speaker_name
      end
    end
  end


end
