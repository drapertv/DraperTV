class TeamMember < ActiveRecord::Base
	mount_uploader :profilepic, ProfilepicUploader
	attr_accessible :name, :position, :linkedin, :current, :profilepic, :email
end