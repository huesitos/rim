class Project
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :scope, type: String
  embeds_many :issues, dependent: :delete
end
