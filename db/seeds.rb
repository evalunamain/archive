# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(user_name: 'Eva')
User.create(user_name: 'Peter')

Poll.create(title: "Test", author_id: 1)
Question.create(body: "Is this working?", poll_id: 1)
AnswerChoice.create(choice: "Possibly", question_id: 1)
AnswerChoice.create(choice: "Absolutely not", question_id: 1)
Response.create(answer_choice_id: 1, user_id: 1)
Response.create(answer_choice_id: 2, user_id: 2)
