class Summary
  include Mongoid::Document
  field :passed, type: Integer
  field :failed, type: Integer
  field :skipped, type: Integer
  field :total, type: Integer

  belongs_to :test_run

  def self.update_summary(summary, result)
  	if result == "Passed"
      summary.inc(passed: 1)
    elsif result == "Skipped"
      summary.inc(skipped: 1)
    elsif result == "Failed"
      summary.inc(failed: 1)
    end
    summary.inc(total: 1)
    summary.save
  end
end
