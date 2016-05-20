class ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]

  def index
    @projects = current_user.projects
  end

  def reset_data
    Project.all.each do |project|
      project.auditions.each do |audition|
        audition.status = ""
        audition.response = ""
        audition.save

        audition.histories.delete_all
        audition.messages.delete_all
        audition.histories.create(action: "Casting creates audition.")
      end
    end

    render json: { message: "Data Reset!" }
  end
end
