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
end
