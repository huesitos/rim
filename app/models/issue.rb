class Issue
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :status, type: Integer, default: 'Open'
  field :description, type: String

  has_and_belongs_to_many :labels
  belongs_to :status
  belongs_to :project
  belongs_to :user
  embeds_many :comments

  def self.get_next_identifier(project_id)
    if Issue.all.entries.last
    	"I#{Integer(Issue.all.entries.last.identifier[/[0-9]+/])+1}"
    else
      "I1"
    end
  end
end
