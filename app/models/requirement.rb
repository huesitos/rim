class Requirement
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :identifier, type: String

  belongs_to :priority
  belongs_to :project
  belongs_to :kind
  has_and_belongs_to_many :use_cases
  has_and_belongs_to_many :test_cases

  validates :description, :identifier, :priority, :kind, presence: true
  validates :project, presence: {is: true, message: "requirements must belong to a project"}
  validates_associated :project

  def self.get_next_identifier(kind, project_id)
    kind = Kind.find_by(name: kind)

    if kind.requirements.entries.last
      "#{kind.identifier}#{Integer(Requirement.where(kind_id: kind.id).entries.last.identifier[/[0-9]+/])+1}"
    else
    	"#{kind.identifier}1"
  	end
  end

  def self.related_use_cases(identifier, project_id)
    UseCase.where({project_id: project_id, "requirements" => { "$elemMatch" => {"identifier" => identifier}}})
  end

  def self.related_test_cases(identifier, project_id)
    TestCase.where({project_id: project_id, "requirements" => { "$elemMatch" => {"identifier" => identifier}}})
  end
end
