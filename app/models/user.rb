class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)

    return nil unless user

    return user if user.is_password?(password)
    nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    save!
  end

end
