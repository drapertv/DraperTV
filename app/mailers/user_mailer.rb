class UserMailer < ActionMailer::Base
	default :from => "support@drapertv.com"

	def expire_email(user)
		mail(:to => user.email, :subject => "Subscription Cancelled")
	end

	def invite_email email
		mail(:to => email, :subject => "Draper TV 2.0")
	end
end
