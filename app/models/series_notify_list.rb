class SeriesNotifyList < ActiveRecord::Base
  acts_as_singleton


  def self.add_email_id id
    if !instance.emails 
      instance.update_attributes emails: [id]
    elsif !instance.emails.include?(id)
      new_email_list = instance.emails.push id
      instance.update_attributes emails: new_email_list
    else  
    end
  end


end