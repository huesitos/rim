class Issue
  include Mongoid::Document
  field :title, type: String
  field :kind, type: String
  field :status, type: Integer, default: 1
  field :description, type: String
  embedded_in :project
  embeds_many :comments
end
