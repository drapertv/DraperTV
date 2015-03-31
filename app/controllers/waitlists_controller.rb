class WaitlistsController < ApplicationController

  def create
    user_exists = User.find_by_email params[:email]
    if !user_exists
      User.invite!(email: params[:email], name: params[:name], role: "waitlisted") do |user|
        user.skip_invitation = true
      end
      render nothing: true and return
    else
      render json: {error: "We already have you in our site."}
    end
  end

end
