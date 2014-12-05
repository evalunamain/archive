class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  has_many :cats

  has_many :cat_rental_requests

  has_many :session_tokens

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
    token = self.session_tokens.new(token: SecureRandom::urlsafe_base64(16), user_id: id)
    token.save!
  end

  def set_session_token!
    new_token = self.session_tokens.new(token: SecureRandom::urlsafe_base64(16), user_id: id)
    new_token.save!
    new_token.token
  end



end
