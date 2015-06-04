class Issue
  include Mongoid::Document
  field :title, type: String
  field :kind, type: String
  field :status, type: String
  embedded_in :project
end
