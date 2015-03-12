class Playlist < ActiveRecord::Base


	# serialize       :video_ids, Array
 #  attr_accessor   :video_ids_raw

 #  def video_ids_raw
 #    self.video_ids.join("\n") unless self.video_ids.nil?
 #  end

 #  def video_ids_raw=(values)
 #    self.video_ids = []
 #    self.video_ids=values.split("\n")
 #  end

end
