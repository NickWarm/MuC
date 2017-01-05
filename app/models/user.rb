class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :posts
  has_many :post_authorities
  has_many :editable_posts, through: :post_authorities, source: :post

  has_attached_file :cover,
    style: {
      original: '1024x1024>',
      medium: '300x300>',
      icon: '150x150#'
    },
    default_url: '/images/missing3.png'
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  def self.from_omniauth(auth)

    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
       user.fb_token = auth.credentials.token

       user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_name = auth.info.name
      existing_user.fb_image = auth.info.image

      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.fb_name = auth.info.name
    user.fb_image = auth.info.image

    user.save!
    return user
  end
end
