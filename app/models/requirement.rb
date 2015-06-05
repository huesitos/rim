class Requirement
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :identifier, type: String
  field :priority, type: String
  field :kind, type: String

  belongs_to :project

  validates :description, :identifier, :priority, :kind, presence: true
  validates :priority, inclusion: { in: %w"Low Medium High" }
  validates :kind, inclusion: { in: %w"Functional Non-Functional" }
  validates :project, presence: {is: true, message: "requirements must belong to a project"}
end
