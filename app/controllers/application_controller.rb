class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_og_tags

  helper ApplicationHelper

  def set_og_tags
    @og_title = "DraperTV"
    @og_description = "Bringing Silicon Valley to You"
    @og_image = "DU_Logo_Gradient_Small.png"
    @meta_description = "Learn about startups, entrepreneurship, and business in Silicon Valley from DraperTV. Watch videos from top Draper University speakers such as Elon Musk, Tony Hsieh, Michelle Phan, and Nate Blecharczyk."
  end
end
