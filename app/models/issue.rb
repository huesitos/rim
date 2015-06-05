class Issue
  include Mongoid::Document
  field :title, type: String
  field :kind, type: String
  field :status, type: Integer, default: 1
  embedded_in :project
end
