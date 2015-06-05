class Project
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :scope, type: String

  has_many :use_cases
end
