class User < ApplicationRecord
  has_secure_password validations: false
  has_many :posts, dependent: :destroy
  
  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }, 
                       length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  
  # Only require password for traditional authentication
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname || auth.info.name || "user_#{SecureRandom.hex(4)}"
      user.email = auth.info.email || "#{SecureRandom.hex(6)}@example.com"
      user.password = SecureRandom.hex(15)
      user.save
    end
  end
  
  private
  
  def password_required?
    provider.blank?
  end
end