class Audition < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  has_many :histories
  has_many :messages
end
