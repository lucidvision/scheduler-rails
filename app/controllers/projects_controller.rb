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
      end
    end

    render json: { message: "Data Reset!" }
  end
end
