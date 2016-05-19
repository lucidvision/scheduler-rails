class HistoriesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :create]

  def index
    @history = current_user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).histories
  end

  def create
    @history = current_user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).histories

    if @history.create(history_params)
      render "index", status: 200
    else
      render json: { errors: history.errors }, status: 422
    end
  end

  private

  def history_params
    params.require(:history).permit(
      :action
    )
  end
end
