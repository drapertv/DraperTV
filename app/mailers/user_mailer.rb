class UserMailer < ActionMailer::Base
	default :from => "Notifier@drapertv.com"

	def signup_all email
		mail(:to => email, :subject => "Welcome to DraperTV!")
	end

	def signup_live email
		mail(:to => email, :subject => "Welcome to DraperTV!")
	end

	def biweekly_all email
		@series = [Series.biweekly_latest[0..1],Series.biweekly_latest[2..-1]]
		@titles = Series.biweekly_latest_titles
		mail(:to => email, :subject => "DraperTV Newsletter")
	end

	def biweekly_live email
		@livestreams = Livestream.biweekly_latest
		@titles = Livestream.biweekly_latest_titles
		mail(:to => email, :subject => "DraperTV Newsletter")
	end

	def update_live email
		@livestreams = Livestream.live_tomorrow
		mail(:to => email, :subject => "DraperTV Newsletter")
	end
end
