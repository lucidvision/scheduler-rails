require 'factory_girl_rails'

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
                              role: "Batman",
                              phone: "7777777",
                              date: "Monday Apr 25",
                              time: "3:50pm")

audition2 = FactoryGirl.create(:audition,
                               project_id: project.id,
                               actor: "Christian Bale",
                               role: "Batman",
                               phone: "7777777",
                               date: "Monday Apr 25",
                               time: "4:00pm")
