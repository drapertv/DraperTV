class Playlist < ActiveRecord::Base
	delegate :profilepic_url, :name, to: :speaker

#Method to update the Array field of the playlist
  def video_ids_raw
    self.video_ids.join("\n,") unless self.video_ids.nil?
  end

  def video_ids_raw=(values)
		int_array = values.split(',').collect{|n| n.to_i}
    self.video_ids =  Array.new(int_array)
  end

  def videos
  	Video.where('id in (?)', video_ids)
  end

  def speaker
  	Speaker.find(author_id)
  end

end
