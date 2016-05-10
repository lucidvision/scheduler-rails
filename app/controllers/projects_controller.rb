class ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]

  def index
    render :json => current_user.projects
  end
end
