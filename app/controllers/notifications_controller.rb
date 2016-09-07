class NotificationsController < ApplicationController

  def create
    email = Email.find_or_create_by(body: params[:email])
    
    if params[:notification_option] == "all_videos"
      SeriesNotifyList.add_email_id email.id
      LivestreamNotifyList.add_email_id email.id
      UserMailer.signup_all(params[:email]).deliver
    end
    
    if params[:notification_option] == "all_livestreams"
      LivestreamNotifyList.add_email_id email.id
      UserMailer.signup_live(params[:email]).deliver
    end
    render nothing: true
  end

  def destroy
    email = Email.find_by_unsubscribe_key params[:unsubscribe_key]
    if email
      LivestreamNotifyList.remove_email_id email.id
      SeriesNotifyList.remove_email_id email.id
    end
  end
end
