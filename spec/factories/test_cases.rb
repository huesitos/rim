FactoryGirl.define do
  factory :test_case do
  	project

    identifier "TC1"
    description "Hello"
		title "Crear caso de uso"
		steps "Dar click al boton de nuevo y completar formulario"
		preconditions "Existen requerimientos"
		postconditions "Se crea un caso de uso en la BD"
		use_cases ["UC1"]
		requirements ["RF1", "NRF2", "RF3"]

		factory :tc_no_title do
			title ""
		end

		factory :tc_no_description do
			description ""
		end

		factory :tc_no_steps do
			steps ""
		end

		factory :tc_no_identifier do
			identifier ""
		end

		factory :tc_wrong_identifier do
			identifier "CP"
		end

		factory :tc_no_project do
			project_id ""
		end

		factory :tc_no_uc_r do
			use_cases []
			requirements []
		end

		factory :tc_only_uc do
			use_cases []
		end

		factory :tc_only_r do
			requirements []
		end
  end

end
