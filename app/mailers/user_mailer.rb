class UserMailer < ActionMailer::Base
	default :from => "kenneth@draperuniversity.com"

	def expire_email(user)
		mail(:to => user.email, :subject => "Subscription Cancelled")
	end

	def invite_email email, name, code
		@name = name
		@code = code
		mail(:to => email, :subject => "Draper TV Courses")
	end
end
