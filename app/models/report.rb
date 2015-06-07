class Report
  include Mongoid::Document
  field :test_case, type: Hash
  field :result, type: String
  field :issues, type: Array
  field :comment, type: String

  belongs_to :test_run

  validates :result, inclusion: {in: %w(Passed Skipped Failed NR)}
  validates :test_case, presence: true
end
