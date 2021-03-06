class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence:true
  validates :username, :session_token, uniqueness:true
  validates :password, length: {minimum:6, allow_nil:true }

  has_many :bookings

  has_many :spots,
    primary_key: :id,
    class_name: :Spot,
    foreign_key: :host_id

  has_many :reviews,
    primary_key: :id,
    class_name: :User,
    foreign_key: :author_id

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return nil unless @user && @user.is_password?(password)
    @user
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
