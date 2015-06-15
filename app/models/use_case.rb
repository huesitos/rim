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
    if UseCase.all.entries.last
      "UC#{Integer(UseCase.all.entries.last.identifier[/[0-9]+/])+1}"
    else
      "UC#{1}"
    end
  end

  def self.related_test_cases(identifier, project_id)
    TestCase.where({project_id: project_id, "use_cases" => { "$elemMatch" => {"identifier" => identifier}}})
  end

  # Format use cases for the text field in the form
  def self.format_use_cases(use_cases)
    identifiers = []

    use_cases.each do |uc|
      identifiers << uc[:identifier]
    end

    identifiers.join(", ")
  end

  # Takes a csv string with use cases and retrieves and returns an array of use cases
  def self.set_use_cases(use_cases_s)
    # Split string of use cases identifier into a list
    use_cases_list = use_cases_s.split(',')

    # Link to use cases, if they exists
    if not use_cases_list.empty?
      use_cases_array = []
      use_cases_list.each do |use_case_identifier|
        use_case_identifier.rstrip.lstrip!
        # In case the use cases exists, add the use case in the test_case.use_cases array
        # as a hash that includes the use_case identifier and id for linking in views
        if use_case = UseCase.find_by(identifier: use_case_identifier)
          use_cases_array << {identifier: use_case.identifier, _id: use_case._id}
        end
      end
    end
    use_cases_array
  end
end
