class User < ApplicationRecord
  # As we don't have a method to destroy user
  # We don't deal with destroying posts when the user is destroyed
  before_create :generate_authentication_token
  has_many :posts
  
 
  before_save { self.email.downcase! }

  validates :name, presence: true, length: { maximum: 50 },uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
      
    # Create a password digest from a string
    def User.digest(string)
      BCrypt::Password.create(string)
    end
    
    def to_param
      name
    end
     #Generate a token to identify an authenticated user
    def generate_authentication_token
      loop do
        self.authentication_token = SecureRandom.base64(64)
        break unless User.find_by(authentication_token: authentication_token)
      end
    end
end
