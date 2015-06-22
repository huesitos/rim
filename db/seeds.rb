# Clean database

Project.all.destroy
Requirement.all.destroy
UseCase.all.destroy
Issue.all.destroy
TestCase.all.destroy
TestRun.all.destroy
Priority.all.destroy
Label.all.destroy
Status.all.destroy
Kind.all.destroy
User.all.destroy

# User owner
denisse = User.create(name: 'Denisse', email: 'denisse@gmail.com', password: Digest::SHA1.hexdigest("123456"))

# Create options

low = Priority.create(name: 'Low')
medium = Priority.create(name: 'Medium')
high = Priority.create(name: 'High')

enhancement = Label.create(name: 'enhancement')
bug = Label.create(name: 'bug')
duplicate = Label.create(name: 'duplicate')
help_wanted = Label.create(name: 'help wanted')
invalid = Label.create(name: 'invalid')
question = Label.create(name: 'question')
wontfix = Label.create(name: 'wontfix')

open = Status.create(name: 'Open')
closed = Status.create(name: 'Closed')

fr = Kind.create(name: 'Functional', identifier: 'FR')
nf = Kind.create(name: 'Non-Functional', identifier: 'NFR')

# Create records

aplus = denisse.projects.create(name: "A+", 
	description: "App that makes studying flashcards more effective.", 
	scope: "The user can: manage flashcards in topics, organize topics in subjects, study flashcards, review flashcards in the right moment before forgetting the content.")

fr1 = aplus.requirements.create(
	title: "Se podrán crear una flashcards en un tema", 
	description: "La aplicacion permitira que el usuario cree flashcards dentro de un tema.",
	kind_id: fr.id,
	identifier: "FR1",
	priority_id: high.id,
	user_id: denisse.id)
fr2 = aplus.requirements.create(
	title: "Se mantendrá récord del tiempo que se tomó responder cada carta", 
	description: "Se mantendrá récord del tiempo que se tomó responder cada carta para hacer un aproximado del tiempo de estudio de un tema.",
	kind_id: fr.id,
	identifier: "FR2",
	priority_id: medium.id,
	user_id: denisse.id)

fr3 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR3",
	priority_id: high.id,
	user_id: denisse.id)
fr4 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR4",
	priority_id: high.id,
	user_id: denisse.id)
fr5 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR5",
	priority_id: high.id,
	user_id: denisse.id)
fr6 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR6",
	priority_id: high.id,
	user_id: denisse.id)
fr7 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR7",
	priority_id: high.id,
	user_id: denisse.id)
fr8 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR8",
	priority_id: high.id,
	user_id: denisse.id)
fr9 = aplus.requirements.create(
	title: "One thing", 
	description: "OHIKO.",
	kind_id: fr.id,
	identifier: "FR9",
	priority_id: high.id,
	user_id: denisse.id)


nfr1 = aplus.requirements.create(
	title: "", 
	description: "Debe haber un menú de acceso rápido para temas y uno para asignaturas.",
	kind_id: nf.id,
	identifier: "NFR1",
	priority_id: high.id,
	user_id: denisse.id)
nfr2 = aplus.requirements.create(
	title: "Tags de asignaturas", 
	description: "En el menú de acceso rápido, al lado del nombre de los temas, aparecerá una etiqueta con el código de la asignatura a la que pertenece con el color de fondo de la asignatura.",
	kind_id: nf.id,
	identifier: "NFR2",
	priority_id: medium.id,
	user_id: denisse.id)

uc1 = aplus.use_cases.create(
	title: "Use case 1",
	preconditions: "Preconditions for UC1",
	postconditions: "postconditions for uc1",
	steps: "1 2 3",
	identifier: "UC1",
	description: "This is uc1",
	priority: high.id,
	user_id: denisse.id)

uc1.requirements << [fr1, nfr2]

uc2 = aplus.use_cases.create(
	title: "Use case 2",
	preconditions: "Preconditions for UC2",
	postconditions: "postconditions for uc2",
	steps: "2 2 3",
	identifier: "UC2",
	description: "This is uc2",
	priority: medium.id,
	user_id: denisse.id)

uc2.requirements << [fr2, nfr1]

uc3 = aplus.use_cases.create(
	title: "Use case 3",
	preconditions: "Preconditions for UC3",
	postconditions: "postconditions for uc3",
	steps: "3 2 3",
	identifier: "UC3",
	description: "This is uc3",
	priority: low.id,
	user_id: denisse.id)

uc3.requirements << [fr2, fr1, nfr1]

tc1 = aplus.test_cases.create(
	identifier: "TC1",
	title: "Test case q",
	steps: "Yeah",
	preconditions: "preconditions for TC1",
	postconditions: "postconditions for tc1",
	description: "This is tc1",
	user_id: denisse.id)

tc1.use_cases << [uc1, uc2]
tc1.requirements << uc1.requirements
tc1.requirements << uc2.requirements

tc2 = aplus.test_cases.create(
	identifier: "TC2",
	title: "Test case 2",
	steps: "Yeah",
	preconditions: "preconditions for TC2",
	postconditions: "postconditions for tc2",
	description: "This is tc2",
	user_id: denisse.id)

tc2.use_cases << [uc1, uc3]
tc2.requirements << uc1.requirements
tc2.requirements << uc3.requirements

tc3 = aplus.test_cases.create(
	identifier: "TC3",
	title: "Test case 3",
	steps: "Yeah",
	preconditions: "preconditions for TC3",
	postconditions: "postconditions for tc3",
	description: "This is tc3",
	user_id: denisse.id)

tc3.use_cases << [uc2, uc3]
tc3.requirements << uc2.requirements
tc3.requirements << uc3.requirements

i1 = aplus.issues.create(
	identifier: 'I1',
	title: "This is a bug",
	description: "Ya should fix it.",
	status_id: open.id,
	user_id: denisse.id)

i1.labels << bug

i2 = aplus.issues.create(
	identifier: 'I2',
	title: "This is an enhancement",
	description: "It's already done.",
	status_id: closed.id,
	user_id: denisse.id)

i2.labels << enhancement

i3 = aplus.issues.create(
	identifier: 'I3',
	title: "Label party",
	description: "Everybody in!",
	status_id: open.id,
	user_id: denisse.id)

i3.labels << [bug, enhancement, duplicate, help_wanted, invalid, question, wontfix]