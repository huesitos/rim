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

  def self.set_use_cases(test_case, use_cases_s)
  	# Split string of use cases identifier into a list
    use_cases_list = use_cases_s.split(',')

    # Link to use cases, if they exists
    if not use_cases_list.empty?
      use_cases_array = []
      use_cases_list.each do |use_case_identifier|
      	use_case_identifier.rstrip!
      	use_case_identifier.lstrip!
        # In case the use cases exists, add the use case in the test_case.use_cases array
        # as a hash that includes the use_case identifier and id for linking in views
        if use_case = UseCase.find_by(identifier: use_case_identifier)
          use_cases_array << {identifier: use_case.identifier, _id: use_case._id}
        end
      end
    end
    use_cases_array
  end

  # Format use cases for the text field in the form
  def self.format_use_cases(use_cases)
  	identifiers = []

  	use_cases.each do |uc|
	  	identifiers << uc[:identifier]
  	end

  	identifiers.join(", ")
  end

  def self.get_identifier
    "TC#{Integer(TestCase.all.count)+1}"
  end
end
