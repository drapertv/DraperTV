class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = current_user
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile_edit
    @user = User.find(params[:id])
    @wrong_password = params[:message] == "wrong_password"
    @bad_match = params[:message] == "bad_match"
  end

  def update
    # authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    params[:user].delete_if {|k,v| v == ""}
    if params[:user][:password]
      if !current_user.valid_password? params[:password]
        redirect_to profile_edit_path(id: current_user.id, message: "wrong_password") and return
      end
      if params[:user][:password] != params[:user][:password_confirmation]
        redirect_to profile_edit_path(id: current_user.id, message: "bad_match") and return
      end
    end
    respond_to do |format|
      if @user.update_attributes(user_params)
        # @user.update_plan(role) unless role.nil?
        format.html { redirect_to profile_edit_path(@user), notice: 'User was successfully updated.' }
        #format.json { head :no_content }
      else
        redirect_to profile_edit_path(@user)
      end
    end
  end

  def accept_invite
    User.accept_invitation!(user_params)
    sign_in User.find(params[:id])
    redirect_to root_path(welcome: true)
  end

  def update_plan
    @user = current_user

    # role_id = params[:user][:role_ids] unless params[:user].nil? || params[:user][:role_ids].nil?
    # role = Role.find_by_id role_id unless role_id.nil?

    # authorized = !role.nil? && (role.name != 'admin' || current_user.role == 'admin')

    # if authorized && @user.update_plan(role)
    #   redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    # else
    #   flash.alert = 'Unable to update plan.'
    #   redirect_to edit_user_registration_path
    # end
  end

  def update_card
    @user = current_user
    # @user.stripe_token = params[:user][:stripe_token]
    # if @user.save
    #   redirect_to edit_user_registration_path, :notice => 'Updated card.'
    # else
    #   flash.alert = 'Unable to update card.'
    #   redirect_to edit_user_registration_path
    # end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def validate_authorization_for_user
    redirect_to root_path unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:current_password, :invitation_token, :invited_by_id, :name, :email, :password, :password_confirmation,:avatar,:remember_me,:bio,:stripe_token, :coupon,:role)
  end


end
