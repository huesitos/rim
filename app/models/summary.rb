class Summary
  include Mongoid::Document
  field :passed, type: Integer
  field :failed, type: Integer
  field :skiped, type: Integer
  field :total, type: Integer

  belongs_to :test_run
end
