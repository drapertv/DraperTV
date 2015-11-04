class EmailsController < ApplicationController

  def create
    Email.create email_params
    render nothing: true
  end

  private

  def email_params
    params.require(:email).permit(:body, :full_name)
  end

end
