class Issue
  include Mongoid::Document
  field :identifier, type: String
  field :title, type: String
  field :kind, type: String
  field :status, type: Integer, default: 1
  field :description, type: String
  belongs_to :project
  embeds_many :comments

  def self.get_next_identifier(project_id)
    if Issue.all.entries.last
    	"I#{Integer(Issue.all.entries.last.identifier[/[0-9]+/])+1}"
    else
      "I1"
    end
  end
end
