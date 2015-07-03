class ManagementController < ApplicationController



	def invitecorner
	end

	def batch_invite
	  #Validate the user_emails field isn't blank and emails are valid
	  @emails = params[:user_emails].split(",")
	  @emails.delete("")
	  @emails.each do |email|
	    UserMailer.invite_email(email).deliver
	  end
	  redirect_to invitecorner_path
	end

private
	def management_params
		params.require(:management).permit(:user_emails)
	end

end
