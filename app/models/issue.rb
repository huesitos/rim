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
  	"I#{Integer(Issue.where(project_id: project_id).count)+1}"
  end
end
