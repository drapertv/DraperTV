class SeriesNotificationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    monthly(1).day_of_week(1 => [1]).hour_of_day(19)
    monthly(1).day_of_week(1 => [3]).hour_of_day(19)
  end
  
  def perform
    SeriesNotifiyList.instance.emails.each do |email_id|
    	email = Email.find email_id
    	UserMailer.biweekly_all(email).deliver
    end
  end
end