class UserMailer < ActionMailer::Base
	default :from => "kenneth@draperuniversity.com"

	def expire_email(user)
		mail(:to => user.email, :subject => "Subscription Cancelled")
	end

	def notification_email media, email
		@media = media
		mail(:to => email, :subject => "Yo shit be ready")
	end
end
