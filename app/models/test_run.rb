class TestRun
  include Mongoid::Document
  field :date, type: Date
  field :tester, type: String

  has_one :summary, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :project
  belongs_to :user

  validates :summary, presence: {is: true, message: "a test run must have a summary"}

  def next_test()
  	report = self.reports.find_by(result: "NR")
  	if report
	  	report.test_case["identifier"]
	  else
	  	nil
  	end
  end

  def get_report(identifier)
    TestCase.find_by(identifier: identifier).reports.find_by(test_run_id: self.id)
  end
end
