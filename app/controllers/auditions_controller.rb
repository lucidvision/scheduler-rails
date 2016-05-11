class AuditionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update]

  def index
    render json: current_user.projects.find(params[:project_id]).auditions
  end

  def update
    user = current_user

    if user.role == 'agent'
      audition = user.projects.find(params[:project_id]).auditions.find(params[:id])
    else
      audition = user.auditions.find(params[:id])
    end

    if audition.update(audition_params)
      render json: audition, status: 200
    else
      render json: { errors: audition.errors }, status: 422
    end
  end

  private

  def audition_params
    params.require(:audition).permit(
      :status,
      :response
    )
  end
end
