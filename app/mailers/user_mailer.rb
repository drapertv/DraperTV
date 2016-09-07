class UserMailer < ActionMailer::Base
	default :from => "DraperTV@drapertv.com"

	def signup_all email
		@unsubscribe_key = Email.find_by_body(email).unsubscribe_key
		mail(:to => email, :subject => "Welcome to DraperTV!")
	end

	def signup_live email
		@unsubscribe_key = Email.find_by_body(email).unsubscribe_key
		mail(:to => email, :subject => "Welcome to DraperTV!")
	end

	def biweekly_all email
		@unsubscribe_key = Email.find_by_body(email).unsubscribe_key
		@series = [Series.biweekly_latest[0..1],Series.biweekly_latest[2..-1]]
		@titles = Series.biweekly_latest_titles
		mail(:to => email, :subject => "DraperTV Newsletter")
	end

	def biweekly_live email
		@unsubscribe_key = Email.find_by_body(email).unsubscribe_key
		@livestreams = Livestream.biweekly_latest
		@titles = Livestream.biweekly_latest_titles
		mail(:to => email, :subject => "DraperTV Newsletter")
	end

	def update_live email
		@unsubscribe_key = Email.find_by_body(email).unsubscribe_key
		@livestreams = Livestream.live_tomorrow
		mail(:to => email, :subject => "DraperTV Newsletter")
	end
end
