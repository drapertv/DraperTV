class Livestream < ActiveRecord::Base
  has_many :comments, :as => :commentable
  acts_as_taggable_on :category

  def comment_form_path
	[self, Comment.new]
  end

  def formatted_stream_date
  	pst_stream_date = stream_date - 7.hours
  	pst_current_time = Time.now.utc - 7.hours
  	if stream_date - Time.now < 24.hours && pst_stream_date.day == pst_current_time.day
  		pst_stream_date.strftime("Today at %l:%M %P PST")
  	elsif stream_date - Time.now < 48.hours && pst_stream_date.day == pst_current_time.day + 1
  		pst_stream_date.strftime("Tommorow at %l:%M %P PST")
  	else
  		pst_stream_date.strftime("%B %d, at %l:%M %P PST")
  	end
  end

  def suggested
    Video.tagged_with(category_list).limit(10)
  end

  def self.next_livestream_info
    livestream = next_livestream

    if livestream.stream_date < Time.now
      "#{livestream.title} NOW"
    else
      "#{livestream.title} #{(livestream.stream_date - 7.hours).strftime("%B %d, at %l:%M %P PST")}"
    end
  end

  def self.next_livestream
    Livestream.where('stream_date > (?)', Time.now - 5.hours).order(:stream_date).first
  end

end