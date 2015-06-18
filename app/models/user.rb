class User
  include Mongoid::Document
  field :email, type: String
  field :name, type: String
  field :password_digest, type: String

  validates :email, presence: true, uniqueness: true

  has_secure_password
end
