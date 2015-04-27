class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user (not logged in)
		if user.role == "admin"
			can :manage, User
			can :manage, Playlist
			can :manage, Video
			can :manage, VideoFeature
			can :manage, Quote
			can :manage, Speaker
		elsif user.role == "beta"
			can :read, Playlist
			can :read, Video
			can :manage, User, :id => user.id
		else
			can :read, Playlist
			can :read, Video
			can :manage, User, :id => user.id
			can :accept_invite, User
			can :read, Livestream
		end
	end
end
