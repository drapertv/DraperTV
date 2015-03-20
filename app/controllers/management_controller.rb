class ManagementController < ApplicationController
	load_and_authorize_resource


	def invitecorner

	end

	def show
	end

	def batch_invite
		  #Validate the user_emails field isn't blank and emails are valid
		  @emails = params[:user_emails]
		  params[:user_emails].split(",").each do |email|
		    User.invite!(:email => email)
		  end
		  #redirect_to appropriate path
	end

private
	def management_params
    params.require(:management).permit(:user_emails)
  end

end