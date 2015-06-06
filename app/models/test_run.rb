class TestRun
  include Mongoid::Document
  field :date, type: Date

  has_one :summary
  has_many :reports

  validates :summary, presence: {is: true, message: "a test run must have a summary"}
end
