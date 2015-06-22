class Issue
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :description, type: String

  has_and_belongs_to_many :labels
  belongs_to :report
  belongs_to :status
  belongs_to :project
  belongs_to :user
  embeds_many :comments

  validates :title, :identifier, :labels, presence: true

  def self.get_next_identifier(project_id)
    if Issue.where(project_id: project_id).entries.last
    	"I#{Integer(Issue.where(project_id: project_id).entries.last.identifier[/[0-9]+/])+1}"
    else
      "I1"
    end
  end
end
