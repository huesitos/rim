class Project
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :scope, type: String

  has_many :issues, dependent: :destroy
  has_many :use_cases, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :test_runs, dependent: :destroy
  belongs_to :user
end
