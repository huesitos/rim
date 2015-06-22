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

  validates :title, :steps, :identifier, presence: true
  validates :title, length: { maximum: 100 }
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

  def self.list(project_id)
    tc_list = []

    TestCase.where(project_id: project_id).sort(identifier: 1).each do |tc|
      tc_list << ["#{tc.identifier} #{tc.title}", tc.id]
    end

    tc_list
  end

  def req_list
    req = []
    self.requirements.each do |r|
      req << r.id
    end

    req
  end

  def uc_list
    uc_list = []
    self.use_cases.each do |uc|
      uc_list << uc.id
    end

    uc_list
  end
end
