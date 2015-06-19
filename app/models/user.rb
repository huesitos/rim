class User
  include Mongoid::Document
  field :email, type: String
  field :name, type: String
  field :password, type: String
  field :role, type: String

  has_many :projects
  has_many :issues, dependent: :destroy
  has_many :use_cases, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :test_runs, dependent: :destroy

  validates :password, presence: true
  validates :email, presence: true, uniqueness: true

  def self.encrypt_password(password)
		Digest::SHA1.hexdigest("#{password}")
  end
end
