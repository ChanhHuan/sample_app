class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length:
    {maximum: Settings.name_length_max}
  validates :email, presence: true, length:
    {maximum: Settings.email_length_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length:
    {minimum: Settings.password_length_min}
  before_save{email.downcase!}
  has_secure_password
end
