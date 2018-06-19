class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  def User.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token
    self.session_token = generate_session_token
    self.save
    self.session_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def password=(pasword)
    @password = pasword
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end