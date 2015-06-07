class Project
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :scope, type: String
  embeds_many :issues

  has_many :use_cases, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  has_many :requirements, dependent: :destroy
end
