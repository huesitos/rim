class TestCase
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :steps, type: String
  field :preconditions, type: String
  field :postconditions, type: String
  field :use_cases, type: Array
  field :requirements, type: Array
end
