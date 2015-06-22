class Requirement
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :identifier, type: String

  belongs_to :priority
  belongs_to :project
  belongs_to :kind
  belongs_to :user
  has_and_belongs_to_many :use_cases
  has_and_belongs_to_many :test_cases

  validates :description, :identifier, :priority, :kind, presence: true
  validates :title, length: { maximum: 100 }
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

  def self.list(project_id)
    req_list = []

      Requirement.where(project_id: project_id).sort(identifier: 1).each do |r|
        req_list << ["#{r.identifier} #{r.title}", r.id]
      end

    req_list
  end
end
