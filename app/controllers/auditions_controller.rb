class AuditionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index]

  def index
    render :json => current_user.projects.find(params[:project_id]).auditions
  end
end
