class LivestreamUpdaterWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day(19)
  end
  
  def perform livestream_id
    unless Livestream.live_tomorrow.empty?
      LivestreamNotifiyList.instance.emails.each do |email_id|
      	email = Email.find email_id
      	UserMailer.update_live(email, next_livestream).deliver
      end
    end
  end
end