FactoryGirl.define do
	factory :use_case do
		project

		title "Crear caso de uso"
		preconditions "Existen requerimientos"
		steps "Dar click al boton de nuevo y completar formulario"
		postconditions "Se crea un caso de uso en la BD"
		requirements ["RF1", "NRF2", "RF3"]
		priority "Low"
		identifier "UC1"
		description "En este caso de uso el usuario crea un nuevo caso de uso."

		factory :uc_no_title do
			title ""
		end

		factory :uc_no_steps do
			steps ""
		end

		factory :uc_no_priority do
			priority ""
		end

		factory :uc_no_description do
			description ""
		end

		factory :uc_no_identifier do
			identifier ""
		end

		factory :uc_wrong_identifier do
			identifier "CU"
		end

		factory :uc_wrong_priority do
			priority "other"
		end

		factory :uc_no_project do
			project_id ""
		end
	end
end