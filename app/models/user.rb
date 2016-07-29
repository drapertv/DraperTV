#deprecated

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_presence_of :email
  has_many :authorizations
  has_many :searches
  has_many :comment, dependent: :destroy
  acts_as_voter
  attr_accessor :stripe_token, :coupon
  after_invitation_accepted :set_role_for_invitee


  #############################################
  ## Login/Authentication                    ##

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  #############################################
  ## Getter/Setters/Misc                     ##

  def save_video_in_view_history video
    if video_view_list.nil? 
      update_attributes video_view_list: [video.id]
    else
      update_attributes video_view_list: (video_view_list + [video.id])
    end
  end

  def avatar_url options=nil
    avatar.url(options)
  end

  private

  def set_role_for_invitee
    inviter = User.find bio
    inviter.update_attributes invitations_count: (invitations_count + 1)
    if inviter.role == "admin"
      update_attributes role: "beta", bio: nil, invited_by_id: bio
    else
      update_attributes role: "invited_by_beta", bio: nil, invited_by_id: bio
    end
  end
end
