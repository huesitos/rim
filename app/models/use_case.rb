class UseCase
  include Mongoid::Document
  field :title, type: String
  field :preconditions, type: String
  field :steps, type: String
  field :postconditions, type: String
  field :requirements, type: String
  field :requirements, type: Array
  field :priority, type: Int
  field :identifier, type: String
end
