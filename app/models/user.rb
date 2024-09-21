class User < ApplicationRecord
  has_many :authentications, dependent: :destroy

  validates :email, uniqueness: true
end
