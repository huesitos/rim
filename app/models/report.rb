class Report
  include Mongoid::Document
  field :result, type: String
  field :comment, type: String
  # field :issues, type: Array

  belongs_to :test_run
  belongs_to :test_case

  validates :result, inclusion: {in: %w(Passed Skipped Failed NR)}
  validates :test_case, presence: true
end
