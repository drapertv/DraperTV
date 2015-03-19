class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)
		if user.role == "admin"
			can :manage, User
			can :manage, Management
			can :manage, Playlist
			can :manage, Video
			can :manage, VideoFeature
			can :manage, Quote
			can :manage, Speaker
		else
			can :read, Playlist
			can :read, Video
			can :manage, User, :id => user.id
		end
	end
end
