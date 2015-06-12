class UseCase
  include Mongoid::Document
  field :title, type: String
  field :preconditions, type: String
  field :steps, type: String
  field :postconditions, type: String
  field :requirements, type: Array
  field :priority, type: String
  field :identifier, type: String
  field :description, type: String

  belongs_to :project

  validates :title, :steps, :priority, :description, :identifier, presence: true
  validates :identifier, format: { with: /\AUC[0-9]+\z/, message: "format UCXX" }
  validates :priority, inclusion: { in: %w(Low Medium High)}
  validates :project, presence: {is: true, message: "use cases must belong to a project"}
  validates_associated :project

  def self.get_next_identifier(project_id)
    "UC#{Integer(UseCase.where(project_id: project_id).count)+1}"
  end

  def self.related_test_cases(identifier, project_id)
    TestCase.where({project_id: project_id, "use_cases" => { "$elemMatch" => {"identifier" => identifier}}})
  end

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
        if requirement = Requirement.find_by(identifier: requiremet_identifier, project_id: project_id)
          requirements_array << {identifier: requirement.identifier, _id: requirement._id}
        end
      end
    end
    requirements_array
  end
end
