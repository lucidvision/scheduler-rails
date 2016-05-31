class Project < ActiveRecord::Base
  has_many :auditions
  belongs_to :user
end
