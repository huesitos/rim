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

  validates :title, :steps, :priority, :identifier, presence: true
  validates :title, length: { maximum: 100 }
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

  def self.list(project_id)
    uc_list = []

      UseCase.where(project_id: project_id).sort(identifier: 1).each do |uc|
        uc_list << ["#{uc.identifier} #{uc.title}", uc.id]
      end

    uc_list
  end

  def req_list
    req = []
    self.requirements.each do |r|
      req << r.id
    end

    req
  end
end
