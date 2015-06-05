FactoryGirl.define do
	factory :use_case do
		project

		title "Crear caso de uso"
		preconditions "Existen requerimientos"
		steps "Dar click al boton de nuevo y completar formulario"
		postconditions "Se crea un caso de uso en la BD"
		requirements ["RF1", "NRF2", "RF3"]
		priority "Low"
		identifier "CU1"
		description "En este caso de uso el usuario crea un nuevo caso de uso."

		factory :no_title do
			title ""
		end

		factory :no_steps do
			steps ""
		end

		factory :no_priority do
			priority ""
		end

		factory :no_description do
			description ""
		end

		factory :no_identifier do
			identifier ""
		end

		factory :wrong_identifier do
			identifier "CU"
		end

		factory :wrong_priority do
			priority "other"
		end

		factory :no_project do
			project_id ""
		end
	end
end