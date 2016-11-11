class OAuthUserValidator < SimpleDelegator
  include ActiveModel::Validations

  validates_presence_of :name, :username, :github_id, :email
  validate :taken_username, :taken_email

  def taken_username
    errors.add(:username, "has already been taken") if User.exists?(username: username)
  end

  def taken_email
    errors.add(:email, "has already been taken") if User.exists?(email: email)
  end
end
