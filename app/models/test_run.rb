class TestRun
  include Mongoid::Document
  field :date, type: Date

  has_one :summary, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :summary, presence: {is: true, message: "a test run must have a summary"}
end
