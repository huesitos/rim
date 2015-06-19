class User
  include Mongoid::Document
  field :email, type: String
  field :name, type: String
  field :password, type: String
  field :role, type: String

  has_many :projects

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true

  def self.encrypt_password(password)
		Digest::SHA1.hexdigest("#{password}")
  end
end
