class UseCase
  include Mongoid::Document
  field :title, type: String
  field :preconditions, type: String
  field :steps, type: String
  field :postconditions, type: String
  field :requirements, type: Array
  field :identifier, type: String
  field :description, type: String

  belongs_to :priority
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :test_cases
  has_and_belongs_to_many :requirements

  validates :title, :steps, :priority, :description, :identifier, presence: true
  validates :identifier, format: { with: /\AUC[0-9]+\z/, message: "format UCXX" }
  validates :project, presence: {is: true, message: "use cases must belong to a project"}
  validates_associated :project

  def self.get_next_identifier(project_id)
    if UseCase.all.entries.last
      "UC#{Integer(UseCase.all.entries.last.identifier[/[0-9]+/])+1}"
    else
      "UC#{1}"
    end
  end

  def self.related_test_cases(identifier, project_id)
    TestCase.where({project_id: project_id, "use_cases" => { "$elemMatch" => {"identifier" => identifier}}})
  end
end
