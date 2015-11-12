class EmailsController < ApplicationController

  def create
    Email.create email_params
    contact = HTTParty.post("https://api2.autopilothq.com/v1/contact",  
      body: {"contact" => {"FirstName" => email_params[:full_name], "Email" => email_params[:body]}}.to_json,
      headers: {"autopilotapikey" => ENV["AUTOPILOT_KEY"]}
    )
    contact_id = contact["contact_id"]
    contact_list_url = "https://api2.autopilothq.com/v1/list/#{ENV['AUTOPILOT_LIST_ID']}/contact/#{contact_id}"
    response = HTTParty.post(contact_list_url, headers: {"autopilotapikey" => ENV["AUTOPILOT_KEY"]})
    render nothing: true
  end

  private

  def email_params
    params.require(:email).permit(:body, :full_name)
  end

end
