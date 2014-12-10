class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :goals

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id
    )



  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def goals_for_user
    all_goals = Hash.new{|hash, key| hash[key] = []}
    self.goals.each do |goal|
      if goal.completed?
        all_goals[:complete] << goal
      else
        all_goals[:incomplete] << goal
      end
    end

    all_goals
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

end
