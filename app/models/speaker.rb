class Speaker < ActiveRecord::Base
	 mount_uploader :profilepic, ProfilepicUploader
end
