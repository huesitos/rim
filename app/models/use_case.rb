class UseCase
  include Mongoid::Document
  field :title, type: String
  field :preconditions, type: String
  field :steps, type: String
  field :postconditions, type: String
  field :requirements, type: Array
  field :priority, type: String
  field :identifier, type: String
  field :description, type: String

  belongs_to :project

  validates :title, :steps, :priority, :description, :identifier, presence: :true
  validates :identifier, format: { with: /\ACU[0-9]+\z/, message: "format CUXX" }
  validates :priority, inclusion: { in: %w(Low Medium High)}
  validates :project, presence: {is: true, message: "use cases have to belong to a project"}
  validates_associated :project
end
