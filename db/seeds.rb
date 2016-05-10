require 'factory_girl_rails'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

agent = FactoryGirl.create(:user,
                           email: "secret.agent@cwb.com",
                           password: "password",
                           role: "agent")

actor = FactoryGirl.create(:user,
                           email: "alister@cwb.com",
                           password: "password",
                           role: "actor")

project = FactoryGirl.create(:project,
                             user_id: agent.id,
                             title: "Batman Returns",
                             director: "Jeff Rose",
                             phone: "7777777",
                             roles: ["Batman", "Robin"])

audition = FactoryGirl.create(:audition,
                              project_id: project.id,
                              actor: "Brad Pitt",
                              phone: "7777777",
                              date: "Monday Apr 25",
                              time: "3:50pm")
