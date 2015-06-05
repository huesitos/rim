class Requirement
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :identifier, type: String
  field :priority, type: String
  field :kind, type: String

  belongs_to :project

  validates :description, :identifier, :priority, :kind, presence: true
  validates :priority, inclusion: { in: %w(Low Medium High) }
  validates :identifier, format: {with: /\A(F|NF)R[0-9]+\z/, message: "format (F|NF)RXX"}
  validates :kind, inclusion: { in: %w(Functional Non-Functional) }
  validates :project, presence: {is: true, message: "requirements must belong to a project"}
  validates_associated :project

  def self.get_next_identifier(kind)
  	if kind == "Functional"
	  	"FR#{Integer(Requirement.where(kind:"Functional").count)+1}"
  	else
	  	"NFR#{Integer(Requirement.where(kind:"Non-Functional").count)+1}"
  	end
  end

  def self.related_use_cases(identifier)
    UseCase.where({"requirements": { "$elemMatch": {"identifier": identifier}}})
  end

  def self.related_test_cases(identifier)
    TestCase.where({"requirements": { "$elemMatch": {"identifier": identifier}}})
  end
end
