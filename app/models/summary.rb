class Summary
  include Mongoid::Document
  field :passed, type: Integer
  field :failed, type: Integer
  field :skipped, type: Integer
  field :total, type: Integer

  belongs_to :test_run
end
