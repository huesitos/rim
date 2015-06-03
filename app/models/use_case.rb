class UseCase
  include Mongoid::Document
  field :title, type: String
  field :preconditions, type: String
  field :steps, type: String
  field :postconditions, type: String
  field :requirements, type: Array
  field :priority, type: Integer
  field :identifier, type: String

  belongs_to :project

  validates :title, :steps, :priority, :identifier, presence: :true
  validates :identifier, format: { with: /\A(CU[0-9]*)\z/, message: "Identifier format CUXX" }
end
