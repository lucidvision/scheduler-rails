require 'factory_girl_rails'

agent = FactoryGirl.create(:user,
                           email: "secret.agent@cwb.com",
                           name: "Shari Caldwell",
                           password: "password",
                           role: "agent")

actors = [
  %w(Cat Lee),
  %w(Pamela Khan),
  %w(Liam Gordon),
  %w(Sean White),
  %w(Ben Bass),
  %w(Austin Crawford),
  %w(Shane Black),
  %w(Mary Stevenson),
  %w(Samantha Simmonds)
]

actors.each do |user|
  actor = FactoryGirl.create(:user,
                             email: "#{ user[0] }.#{ user[1] }@cwb.com",
                             name: "#{ user[0] } #{ user[1] }",
                             password: "password",
                             role: "actor")
end

project1 = FactoryGirl.create(:project,
                             user_id: agent.id,
                             title: "Vikings",
                             director: "Deirdre Bowen",
                             phone: "6043497242",
                             roles: ["Ubbe", "Boneless"])

project2 = FactoryGirl.create(:project,
                              user_id: agent.id,
                              title: "Quantico Episode 119",
                              director: "Andrea Kenyon",
                              phone: "6043497242",
                              roles: ["Dan Berlin", "Marshall Freed"])

project3 = FactoryGirl.create(:project,
                              user_id: agent.id,
                              title: "Murdoch Mysteries: Concocting a Killer",
                              director: "Diane Kerbel",
                              phone: "6043497242",
                              roles: ["Miss Hanover"])

audition1 = FactoryGirl.create(:audition,
                               project_id: project1.id,
                               user_id: 2,
                               actor: "Cat Lee",
                               title: project1.title,
                               role: "Ubbe",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "3:50pm")

history = FactoryGirl.create(:history,
                             audition_id: audition1.id,
                             action: "Deirdre Bowen sent request.")

audition2 = FactoryGirl.create(:audition,
                               project_id: project1.id,
                               user_id: 3,
                               actor: "Pamela Khan",
                               title: project1.title,
                               role: "Ubbe",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "4:00pm")

history = FactoryGirl.create(:history,
                             audition_id: audition2.id,
                             action: "Deirdre Bowen sent request.")

audition3 = FactoryGirl.create(:audition,
                               project_id: project1.id,
                               user_id: 4,
                               actor: "Liam Gordon",
                               title: project1.title,
                               role: "Boneless",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "4:10pm")

history = FactoryGirl.create(:history,
                             audition_id: audition3.id,
                             action: "Deirdre Bowen sent request.")

audition4 = FactoryGirl.create(:audition,
                               project_id: project1.id,
                               user_id: 5,
                               actor: "Sean White",
                               title: project1.title,
                               role: "Boneless",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "4:20pm")

history = FactoryGirl.create(:history,
                             audition_id: audition4.id,
                             action: "Deirdre Bowen sent request.")

audition5 = FactoryGirl.create(:audition,
                              project_id: project2.id,
                              user_id: 6,
                              actor: "Ben Bass",
                              title: project2.title,
                              role: "Dan Berlin",
                              phone: "6043497242",
                              date: "Monday June 28",
                              time: "4:20pm")

history = FactoryGirl.create(:history,
                            audition_id: audition5.id,
                            action: "Andrea Kenyon sent request.")

audition6 = FactoryGirl.create(:audition,
                               project_id: project2.id,
                               user_id: 7,
                               actor: "Austin Crawford",
                               title: project2.title,
                               role: "Dan Berlin",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "4:30pm")

history = FactoryGirl.create(:history,
                             audition_id: audition6.id,
                             action: "Andrea Kenyon sent request.")

audition7 = FactoryGirl.create(:audition,
                              project_id: project2.id,
                              user_id: 8,
                              actor: "Shane Black",
                              title: project2.title,
                              role: "Marshall Freed",
                              phone: "6043497242",
                              date: "Monday June 25",
                              time: "4:40pm")

history = FactoryGirl.create(:history,
                            audition_id: audition7.id,
                            action: "Andrea Kenyon sent request.")

audition8 = FactoryGirl.create(:audition,
                               project_id: project2.id,
                               user_id: 9,
                               actor: "Mary Stevenson",
                               title: project2.title,
                               role: "Marshall Freed",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "4:50pm")

history = FactoryGirl.create(:history,
                             audition_id: audition8.id,
                             action: "Andrea Kenyon sent request.")

audition9 = FactoryGirl.create(:audition,
                               project_id: project3.id,
                               user_id: 10,
                               actor: "Samantha Simmonds",
                               title: project3.title,
                               role: "Miss Hanover",
                               phone: "6043497242",
                               date: "Monday June 25",
                               time: "5:00pm")

history = FactoryGirl.create(:history,
                             audition_id: audition9.id,
                             action: "Diane Kerbel sent request.")

audition10 = FactoryGirl.create(:audition,
                                project_id: project3.id,
                                user_id: 2,
                                actor: "Cat Lee",
                                title: project3.title,
                                role: "Miss Hanover",
                                phone: "6043497242",
                                date: "Monday June 25",
                                time: "5:10pm")

history = FactoryGirl.create(:history,
                             audition_id: audition10.id,
                             action: "Diane Kerbel sent request.")
