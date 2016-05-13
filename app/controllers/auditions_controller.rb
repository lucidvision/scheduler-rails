class AuditionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update]

  def index
    user = current_user

    if user.role == 'agent'
      render json: user.projects.find(params[:project_id]).auditions
    else
      render json: user.auditions.where("status is NOT NULL and status != ''")
    end
  end

  def update
    user = current_user

    audition = user.auditions.find(params[:id])

    if audition.update(audition_params)
      render json: user.auditions, status: 200
    else
      render json: { errors: audition.errors }, status: 422
    end
  end

  def update_status
    user = current_user

    params[:selected].each do |audition_id|
      audition = Audition.find(audition_id)
      if params[:status] == 'CAST'
        if audition.status == 'CONF'
          audition.response = 'confirm'
        elsif audition.status == 'TIME'
          audition.response = 'time'
        elsif audition.status == 'REGR'
          audition.response = 'regret'
        end
      else
        audition.status = params[:status]
      end
      audition.save
    end

    render json: user.projects.find(params[:project_id]).auditions, status: 200
  end

  private

  def audition_params
    params.require(:audition).permit(
      :status,
      :response
    )
  end
end
