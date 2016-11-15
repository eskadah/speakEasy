class User < ApplicationRecord
  has_secure_password :validations => false

  validates :name, :presence => true
  validates :phone_number, :presence => true, :format => { :with => /\d{10}/ }, :if => proc { |user| user.has_phone? }
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, :format => { :with => /\A[\w.+-]+@([\w]+\.)+\w{3}\Z/ }

  has_many :events, inverse_of: :speaker, dependent: :destroy

  enum communication_preference: { email: '0', phone: '1', all_comms: '2' }

  def self.find_or_create_with_auth_hash(auth_hash)
    if user = User.find_by(github_id: auth_hash["uid"])
      user
    elsif user = User.find_by(email: auth_hash["info"]["email"])
      user.github_id = auth_hash["uid"]
      user.save
      user
    else
      User.build_from_auth_hash(auth_hash)
    end
  end

  def self.build_from_auth_hash(auth_hash)
    User.new(
      name: auth_hash["info"]["name"],
      github_id: auth_hash["uid"], 
      email: auth_hash["info"]["email"],
      username: auth_hash["info"]["nickname"]
      )
  end

  protected

  def has_phone?
    phone? || all_comms?
  end
end
