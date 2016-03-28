class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_device_type
  before_filter :set_og_tags

  helper ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  if Rails.env.production?
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers
    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = 'http://faymotherapp.herokuapp.com'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = 'http://faymotherapp.herokuapp.com'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.
    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = 'http://faymotherapp.herokuapp.com'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = 'http://faymotherapp.herokuapp.com'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        render :text => '', :content_type => 'text/plain'
      end
    end
  end

  helper_method :resource, :resource_name, :devise_mapping
  def resource_name
    :user
  end

  def set_device_type #allows use of @browser.mobile? in views
    @browser = Browser.new("Some User Agent", accept_language: "en-us")
    @mobile = @browser.device.mobile? || @browser.device.tablet?
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :remember_me, :email, :password, :password_confirmation) }
  end

  def set_og_tags
    @og_title = "DraperTV"
    @og_description = "Bringing Silicon Valley to You"
    @og_image = "DU_Logo_Gradient_Small.png"
    @meta_description = "Learn about startups, entrepreneurship, and business in Silicon Valley from DraperTV. Watch videos from top Draper University speakers such as Elon Musk, Tony Hsieh, Michelle Phan, and Nate Blecharczyk."
  end
end
