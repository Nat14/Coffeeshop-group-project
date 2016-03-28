class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, presence: true


  # has_attached_file :avatar, styles: { small: "64x64", med: "100x100", large: "200x200" }
  # validates_attachment :avatar, presence: true,
  #   content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  #   size: { in: 0..10.megabytes }


  has_many :usermeetings
  has_many :meetings, through: :usermeetings
  has_many :searches

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.avatar =  "https://graph.facebook.com/#{auth["uid"]}/picture?type=large"

    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_passwords.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  private

    def process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end


end
