class User < ActiveRecord::Base
  validates :name, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  before_save :downcase_email
  has_many :secrets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  def downcase_email 
    self.email = self.email.downcase
  end
end
