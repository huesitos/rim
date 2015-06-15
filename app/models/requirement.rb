class Requirement
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :identifier, type: String

  has_one :priority
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

  # Format use cases for the text field in the form
  def self.format_requirements(requirements)
    identifiers = []

    requirements.each do |rq|
      identifiers << rq[:identifier]
    end

    identifiers.join(", ")
  end

  # Takes a csv string and retrieves and returns an array of requirements
  def self.set_requirements(requirements_s, project_id)
    # Split string of requirements identifier into a list
    requirements_list = requirements_s.split(',')

    # Link to use cases, if they exists
    if not requirements_list.empty?
      requirements_array = []
      requirements_list.each do |requiremet_identifier|
        requiremet_identifier.rstrip.lstrip!
        # In case the requirement exists, add the requirement in the test_case.requirements array
        # as a hash that includes the requirement identifier and id for linking in views
        if requirement = Requirement.find_by(identifier: requiremet_identifier)
          requirements_array << {identifier: requirement.identifier, _id: requirement._id}
        end
      end
    end
    requirements_array
  end
end
