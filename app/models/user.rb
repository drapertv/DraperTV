class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_presence_of :email
  mount_uploader :avatar, AvatarUploader
  has_many :authorizations
  acts_as_voter
  attr_accessor :stripe_token, :coupon
  after_invitation_accepted :set_role_for_invitee


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

  def save_video_in_view_history video
    if video_view_list.nil? 
      update_attributes video_view_list: [video.id]
    else
      update_attributes video_view_list: (video_view_list + [video.id])
    end
  end


  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.name = auth.info.name
        user.email = auth.info.email
        user.profile_pic_url = auth.info.image + "?type=large"
        user.skip_confirmation!
        auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

  def invited_email_list
    email_list = (User.where(invited_by_id: id).pluck(:email) + User.where(bio: "#{id}").pluck(:email))[0..4]
    if email_list.length == 5
      email_list
    else
      (email_list + [nil,nil,nil,nil,nil])[0..4]
    end
  end

  def invites_remaining
    5 - invited_email_list.compact.count
  end


  # def update_plan(role)
  #   self.role_ids = []
  #   self.add_role(role.name)
  #   unless customer_id.nil?
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     customer.update_subscription(:plan => role.name)
  #   end
  #   true
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "Unable to update your subscription. #{e.message}."
  #   false
  # end

  # def update_stripe
  #   return if email.include?(ENV['ADMIN_EMAIL'])
  #   return if email.include?('@example.com') and not Rails.env.production?
  #   if customer_id.nil?
  #     if !stripe_token.present? && roles.first.name != 'free'
  #       raise "Stripe token not present. Can't create account."
  #     end
  #     if roles.first.name == 'free'
  #       customer = Stripe::Customer.create(
  #         :email => email,
  #         :description => name,
  #         :plan => roles.first.name
  #       )
  #     else
  #       customer = Stripe::Customer.create(
  #         :email => email,
  #         :description => name,
  #         :card => stripe_token,
  #         :plan => roles.first.name
  #       )
  #     end
  #   else
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     if stripe_token.present?
  #       customer.card = stripe_token
  #     end
  #     customer.email = email
  #     customer.description = name
  #     customer.save
  #   end
  #   self.last_4_digits = customer.cards.first["last4"] if customer.cards.any?
  #   self.customer_id = customer.id
  #   self.stripe_token = nil
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "#{e.message}."
  #   self.stripe_token = nil
  #   false
  # end

  # def cancel_subscription
  #   unless customer_id.nil?
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     unless customer.nil? or customer.respond_to?('deleted')
  #       subscription = customer.subscriptions.data[0]
  #       if subscription.status == 'active'
  #         customer.cancel_subscription
  #       end
  #     end
  #   end
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "Unable to cancel your subscription. #{e.message}."
  #   false
  # end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def avatar_url options=nil
    (avatar.url == "default.png" && profile_pic_url) ? profile_pic_url : avatar.url(options)
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
