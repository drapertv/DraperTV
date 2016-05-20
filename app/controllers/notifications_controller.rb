class NotificationsController < ApplicationController

def create
  email = Email.find_or_create_by(body: params[:email])
  binding.pry
  if params[:notification_options] == "all_videos"
    SeriesNotifyList.add_email_id email.id
    LivestreamNotifyList.add_email_id email.id
  end
  if params[:notification_options] == "all_livestreams"
    LivestreamNotifyList.add_email_id email.id
  end
  
  if params[:livestream]
    Notification.create email_id: email.id, livestream_id: params[:livestream]
  end
  render nothing: true
end

private


end
