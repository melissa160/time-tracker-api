class User < ApplicationRecord
  has_secure_password
  has_many :time_tracker_employees

  validates :email, presence: true
end
