class HistoriesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :create]

  def index
    user = current_user

    if user.role == 'agent'
      render json: user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).histories
    else
      render json: user.auditions.find(params[:id]).histories
    end
  end

  def create
    histories = current_user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).histories

    if histories.create(history_params)
      render json: histories, status: 200
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
