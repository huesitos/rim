FactoryGirl.define do
  factory :test_case do
  	project

    identifier ""
		title "Crear caso de uso"
		steps "Dar click al boton de nuevo y completar formulario"
		preconditions "Existen requerimientos"
		postconditions "Se crea un caso de uso en la BD"
		use_cases ["UC1"]
		requirements ["RF1", "NRF2", "RF3"]

		factory :no_title do
			title ""
		end

		factory :no_steps do
			steps ""
		end

		factory :no_identifier do
			identifier ""
		end

		factory :wrong_identifier do
			identifier "CP"
		end

		factory :no_project do
			project_id ""
		end
  end

end
