class Video < ActiveRecord::Base
	has_many :comments, :as => :commentable
  has_many :categories, through: :categorizations
  has_many :categorizations

  mount_uploader :vthumbnail, VthumbnailUploader
  # delegate :vthumbnail_url, to: :series
  # delegate :vthumbnail, to: :series

  validates :title, :student_name, :slug, :presence => true
  

  extend FriendlyId
  
  friendly_id :title, use: :slugged

  delegate :profilepic_url, :name, :challenge, :speaker_position, :speaker_name, :thumbnail_title, :description, to: :series

  after_update :expire_cache
  after_create :expire_cache
  after_destroy :expire_cache

  include Extensions::Viewable
  include Extensions::Publishable
  include Extensions::Suggestable

	def order_in_series
		ids = series.video_ids
		"#{(ids.find_index(id) || 0) + 1}/#{ids.length}" 
	end

	def series
		Series.where("'#{id}' = ANY (video_ids) ").first || Series.first
	end

	def comment_form_path
		[self, Comment.new]
	end

	def time_diff
		Time.now - created_at
	end

	def thumbnail options=nil
		options ? series.videos.first.vthumbnail_url(options) : series.videos.first.vthumbnail_url
	end

  def seconds_elapsed_since_creation
    (Time.now - created_at).floor
  end

  def industries
    (1..10).map {|n| "industry-#{n}"}.sample(3).join(" ")
  end

  def html_description
    description.gsub("\n", "<br>").html_safe if description
  end

  def thumbnail_title
    title
  end

  def self.update_all_view_counts
    all.each do |video|
      youtube_video = Yt::Video.new id: video.url
      begin 
        video.update_attributes view_count: youtube_video.view_count
      rescue
        p video.title
      end
    end
    Series.get_view_counts_from_videos
  end

  def category
    if !video_type
      series.category
    else
      categories.first ? categories.first.name : "No Category"
    end
  end

  def category_name
    categories.pluck(:name).first.gsub(" ", "-").downcase unless categories.empty?
  end

   ransacker :by_categorization, formatter: proc{ |v|

    Category.find_by_name(v).videos.pluck :id
    nil if !(Category.find_by_name(v).videos.pluck :id)
  } do |parent|
    parent.table[:id]
  end



	private

	def expire_cache
		ActionController::Base.new.expire_fragment('all_videos')
		ActionController::Base.new.expire_fragment('featured_videos')
		ActionController::Base.new.expire_fragment('all_series')
    ActionController::Base.new.expire_fragment('homepage')
	end
end
