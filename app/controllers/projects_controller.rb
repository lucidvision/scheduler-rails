class ProjectsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]

  def index
    user = current_user

    render :json => user.projects
  end
end
