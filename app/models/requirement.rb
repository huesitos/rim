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

  def self.get_next_identifier(kind, project_id)
  	if kind == "Functional"
	  	"FR#{Integer(Requirement.where(kind:"Functional", project_id: project_id).count)+1}"
  	else
	  	"NFR#{Integer(Requirement.where(kind:"Non-Functional", project_id: project_id).count)+1}"
  	end
  end

  def self.related_use_cases(identifier, project_id)
    UseCase.where({project_id: project_id, "requirements" => { "$elemMatch" => {"identifier" => identifier}}})
  end

  def self.related_test_cases(identifier, project_id)
    TestCase.where({project_id: project_id, "requirements" => { "$elemMatch" => {"identifier" => identifier}}})
  end
end
