class TestCase
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :steps, type: String
  field :preconditions, type: String
  field :postconditions, type: String
  field :description, type: String

  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :use_cases
  has_and_belongs_to_many :requirements
  has_many :reports

  validates :title, :steps, :description, :identifier, presence: true
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
