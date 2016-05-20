class AuditionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update]

  def index
    user = current_user

    if user.role == 'agent'
      render json: user.projects.find(params[:project_id]).auditions.reverse
    else
      render json: user.auditions.where("status is NOT NULL and status != ''").reverse
    end
  end

  def update
    user = current_user
    audition = user.auditions.find(params[:id])

    if params[:audition][:status] == 'CONF'
      action = "Actor responds with Confirm."
    elsif params[:audition][:status] == 'TIME'
      action = "Actor responds with Alternative Time."
    elsif params[:audition][:status] == 'REGR'
      action = "Actor responds with Regret."
    end

    if audition.update(audition_params)
      audition.histories.create(action: action)
      render json: user.auditions.reverse, status: 200
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
          action = "Forwarded Confirm to Casting."
        elsif audition.status == 'TIME'
          audition.response = 'time'
          action = "Forwarded Alternative Time to Casting."
        elsif audition.status == 'REGR'
          audition.response = 'regret'
          action = "Forwarded Regret to Casting."
        end
        audition.histories.create(action: action)

      else
        audition.status = params[:status]

        if params[:status] == 'SENT'
          action = "Sent audition request to Actor."
        elsif params[:status] == 'SENT+'
          action = "Sent audition request plus materials to Actor."
        elsif params[:status] == 'CONF'
          action = "Set audition status to Confirm."
        elsif params[:status] == 'TIME'
          action = "Set audition status to Alternative Time."
        elsif params[:status] == 'REGR'
          action = "Set audition status to Regret."
        elsif params[:status] == 'CALL'
          action = "Called the Actor."
        end
        audition.histories.create(action: action)

      end
      audition.save
    end

    render json: user.projects.find(params[:project_id]).auditions.reverse, status: 200
  end

  private

  def audition_params
    params.require(:audition).permit(
      :status,
      :response
    )
  end
end
