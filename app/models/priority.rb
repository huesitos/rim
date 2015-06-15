class Priority
  include Mongoid::Document
  field :name, type: String

  belongs_to :use_case
  belongs_to :requirement
end
