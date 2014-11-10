class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :validate_authorization_for_user, only: [:edit, :update]
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def profile_edit
      @user = User.find(params[:id])
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to profile_edit_path(@user), notice: 'User was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation,:avatar,:remember_me,:about)
    end


end
