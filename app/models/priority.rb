class Priority
  include Mongoid::Document
  field :name, type: String

  has_many :use_case
  has_many :requirement
end
