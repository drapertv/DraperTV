class LivestreamNotificationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    monthly(1).day_of_week(1 => [0]).hour_of_day(19)
    monthly(1).day_of_week(1 => [2]).hour_of_day(19)
  end
  
  def perform
    LivestreamNotifiyList.instance.emails.each do |email_id|
    	email = Email.find email_id
    	UserMailer.biweekly_live(email).deliver
    end
  end
end