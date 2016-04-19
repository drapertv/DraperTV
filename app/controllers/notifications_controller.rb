class NotificationsController < ApplicationController

def create
  email = Email.find_or_create_by(body: params[:email])
  if params[:all_videos] == "true"
    SeriesNotifyList.add_email_id email.id
  end
  if params[:all_livestreams] == "true"
    LivestreamNotifyList.add_email_id email.id
  end
  
  if params[:livestream]
    Notification.create email_id: email.id, livestream_id: params[:livestream]
  end
  render nothing: true
end

private


end
