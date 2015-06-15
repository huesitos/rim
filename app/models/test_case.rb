class TestCase
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :steps, type: String
  field :preconditions, type: String
  field :postconditions, type: String
  field :use_cases, type: Array
  field :requirements, type: Array
  field :description, type: String

  belongs_to :project

  validates :title, :steps, :description, :identifier, presence: true
  validates :requirements, presence: true, if: "use_cases.nil? or use_cases.empty?"
  validates :use_cases, presence: true, if: "requirements.nil? or requirements.empty?"
  validates :identifier, format: { with: /\ATC[0-9]+\z/, message: "format TCXX" }
  validates :project, presence: {is: true, message: "test cases must belong to a project"}
  validates_associated :project

  def self.get_next_identifier(project_id)
    if TestCase.all.entries.last
      "TC#{Integer(TestCase.all.entries.last.identifier[/[0-9]+/])+1}"
    else
      "TC1"
    end
  end
end
