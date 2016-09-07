class Series < ActiveRecord::Base
  acts_as_votable

  # validates :title, :speaker_name, :speaker_position, :slug, :presence => true


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
    if found_videos.first && found_videos.first.order
      return found_videos.order(:order)
    elsif found_videos.first
      return found_videos.order(:id)
    else
      return [Video.first]
    end
  end

  def video_count
    videos.count
  end

  def speaker_title
    speaker_position
  end

  def html_description
    description.gsub("\n", "<br>").html_safe if description
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
    manually_selected_to_front_page = manually_selected_to_front_page.sort_by(&:order)
    
    
    if manually_selected_to_front_page.count < 3
      
      items = [nil,nil,nil]
      manually_selected_to_front_page.each do |media|
        if media.order
          items[media.order.to_i] = media
        end
      end

      featured_series = Series.order('created_at desc').limit(2).to_a
      featured_livestream = Livestream.next_livestream
      if !featured_livestream
        featured_livestream = [Livestream.last]
      end
      auto_populated_featured_media = featured_series + featured_livestream
      
      counter = -1
      items.map! do |item|
        if item == nil
          counter += 1
          auto_populated_featured_media[counter]
        else
          item
        end
      end
      front_page_media = items
    else
      front_page_media = manually_selected_to_front_page
    end
    front_page_media
  end

  def self.reorder_collection collection
    items = [nil,nil,nil,nil,nil]
    

  end

  def self.featured_to_edit #for editing in the admin panel
    featured
  end

  def self.update_featured slugs
    Series.update_all show_on_front_page: false, order: nil
    Livestream.update_all show_on_front_page: false, order: nil
    # binding.pry
    slugs.each_with_index do |slug, i|
      media = Series.where slug: slug
      unless media.empty?
        media.first.update_attributes show_on_front_page: true, order: i
      end
      media = Livestream.where slug: slug
      unless media.empty?
        media.first.update_attributes show_on_front_page: true, order: i
      end
    end
  end

  def featured_top_info
    "#{speaker_name}, #{speaker_position}"
  end

  def featured_title
    title.upcase
  end

  def featured_subtitle
    nil
  end

  def self.popular
    manually_popular = where(popular: true).order(:order)
    auto_populated_popular = order('view_count desc').limit(5)

    if manually_popular.count < 5
      items = [nil,nil,nil,nil,nil]
      manually_popular.each do |media|
        if media.order
          items[media.order.to_i] = media
        end
      end
    

      counter = -1
      items.map! do |item|
        if item == nil
          counter += 1
          auto_populated_popular[counter]
        else
          item
        end
      end
      return items
    end
    manually_popular
  end

  def self.popular_to_edit
    popular
  end

  def self.update_popular slugs
    Series.update_all popular: false
    slugs.each_with_index do |slug, i|
      media = Series.where slug: slug
      unless media.empty?
        media.first.update_attributes popular: true, order: i
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

  def self.populate_video_speaker_fields
    all.each do |series|
      if series.author_id
        speaker = Speaker.find(series.author_id)
        speaker_name = speaker.name
        speaker_position = speaker.title
        series.update_attributes speaker_name: speaker_name, speaker_position: speaker_position
      end
    end
  end

  def self.populate_speaker_and_slug_for_series_and_livestreams
    populate_video_speaker_fields
    populate_slugs
    Livestream.seed_speaker_name_and_position
    Livestream.seed_slugs
  end

  def category_name
    categories.pluck(:name).first.gsub(" ", "-").downcase unless categories.empty?
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

  def self.biweekly_latest
    order('created_at desc').limit(4)
  end

  def self.biweekly_latest_titles
   biweekly_latest.pluck(:title).join(" | ")
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
