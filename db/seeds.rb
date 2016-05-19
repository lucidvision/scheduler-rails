require 'factory_girl_rails'

agent = FactoryGirl.create(:user,
                           email: "secret.agent@cwb.com",
                           name: "James Bond",
                           password: "password",
                           role: "agent")

actor = FactoryGirl.create(:user,
                           email: "alister@cwb.com",
                           name: "Brad Pitt",
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
                              user_id: actor.id,
                              actor: actor.name,
                              title: project.title,
                              role: "Batman",
                              phone: "7777777",
                              date: "Monday Apr 25",
                              time: "3:50pm")

history = FactoryGirl.create(:history,
                             audition_id: audition.id,
                             action: "Casting creates audition.")
