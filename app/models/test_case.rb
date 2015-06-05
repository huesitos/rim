class TestCase
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :steps, type: String
  field :preconditions, type: String
  field :postconditions, type: String
  field :use_cases, type: Array
  field :requirements, type: Array
  field :description, type: String

  belongs_to :project

  validates :title, :steps, :description, :identifier, presence: true
  validates :requirements, presence: true, if "use_cases.empty?"
  validates :use_cases, presence: true, if "requirements.empty?"
  validates :identifier, format: { with: /\ACP[0-9]+\z/, message: "format CPXX" }
  validates :project, presence: {is: true, message: "use cases have to belong to a project"}
  validates_associated :project
end
