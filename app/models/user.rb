class User < ApplicationRecord
  has_secure_password

  validates :name, :presence => true
  validates :username, uniqueness: true, presence:true
  validates :email, uniqueness: true, presence:true, :format => {:with => /\A[\w.+-]+@([\w]+\.)+\w{3}\Z/}

  has_many :events, inverse_of: :speaker,dependent: :destroy

end
