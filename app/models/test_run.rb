class TestRun
  include Mongoid::Document
  field :date, type: DateTime

  has_one :summary, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :project

  validates :summary, presence: {is: true, message: "a test run must have a summary"}

  def self.next_test(test_run)
  	report = test_run.reports.find_by(result: "NR")
  	if report
	  	report.test_case["identifier"]
	  else
	  	nil
  	end
  end

  def self.get_report(test_run, identifier)
  	report = test_run.reports.find_by({
      "test_case.identifier" => identifier
      })
  end
end
