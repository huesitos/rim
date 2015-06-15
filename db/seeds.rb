# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Requirement.all.destroy
UseCase.all.destroy
Issue.all.destroy
TestCase.all.destroy
TestRun.all.destroy
Priority.all.destroy
Label.all.destroy
Status.all.destroy

Priority.create(name: 'Low')
Priority.create(name: 'Medium')
Priority.create(name: 'High')

Label.create(name: 'Enhancement')
Label.create(name: 'Error')
Label.create(name: 'Modify')

Status.create(name: 'Open')
Status.create(name: 'Closed')