class User
  include Mongoid::Document
  include BCrypt
  field :email, type: String
  field :name, type: String
  field :password, type: String

  has_many :projects

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true
end
