class Kind
  include Mongoid::Document
  field :name, type: String
  field :identifier, type: String

  has_many :requirements
end
