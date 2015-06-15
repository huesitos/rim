FactoryGirl.define do
  factory :requirement do
  	project 

    title "Se debe poder crear una carta"
		description "El usuario podra crear una carta dentro de un tema."
		identifier "FR1"
		priority "High"
		kind "Functional"

		factory :rq_no_kind do
			kind ""
		end

		factory :rq_wrong_kind do
			kind "functional"
		end

		factory :rq_no_description do
			description ""
		end

		factory :rq_no_identifier do
			identifier ""
		end

		factory :rq_wrong_identifier do
			identifier "F"
		end

		factory :rq_wrong_priority do
			priority "other"
		end

		factory :rq_no_project do
			project_id ""
		end
  end
end
