class AuditionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update]

  def index
    user = current_user

    if user.role == 'agent'
      render json: user.projects.find(params[:project_id]).auditions.order(:time)
    else
      render json: user.auditions.where("status is NOT NULL and status != ''").order(:time)
    end
  end

  def update
    user = current_user
    audition = user.auditions.find(params[:id])

    if params[:audition][:status] == 'CONF'
      action = "#{user.name} responds with Confirm."
    elsif params[:audition][:status] == 'TIME'
      action = "#{user.name} responds with Alternative Time."
    elsif params[:audition][:status] == 'REGR'
      action = "#{user.name} responds with Regret."
    end

    if audition.update(audition_params)
      audition.histories.create(action: action)

      agent = audition.project.user
      token = [agent.notification_token]
      create_notification(agent.platform, token, "Audition Update", "Actor has responded")

      render json: user.auditions.where("status is NOT NULL and status != ''").order(:time), status: 200
    else
      render json: { errors: audition.errors }, status: 422
    end
  end

  def update_status
    user = current_user

    android_tokens = Array.new
    ios_tokens = Array.new
    params[:selected].each do |audition_id|
      audition = Audition.find(audition_id)
      actor = audition.user

      if params[:status] == 'CAST'
        director = audition.project.director
        if audition.status == 'CONF'
          audition.response = 'confirm'
          action = "Forwarded Confirm to #{director}."
        elsif audition.status == 'TIME'
          audition.response = 'time'
          action = "Forwarded Alternative Time to #{director}."
        elsif audition.status == 'REGR'
          audition.response = 'regret'
          action = "Forwarded Regret to #{director}."
        end
        audition.histories.create(action: action)

      else
        audition.status = params[:status]

        if params[:status] == 'SENT'
          action = "Sent audition request to #{actor.name}."
        elsif params[:status] == 'SENT+'
          action = "Sent audition request plus materials to #{actor.name}."
        elsif params[:status] == 'CONF'
          audition.response = 'confirm'
          action = "#{user.name} set audition status to Confirm."
        elsif params[:status] == 'TIME'
          audition.response = 'time'
          action = "#{user.name} audition status to Alternative Time."
        elsif params[:status] == 'REGR'
          audition.response = 'regret'
          action = "#{user.name} audition status to Regret."
        elsif params[:status] == 'CALL'
          action = "Called #{actor.name}."
        end
        audition.histories.create(action: action)

        if actor.platform == "android"
          android_tokens.push(actor.notification_token)
        elsif actor.platform == "ios"
          ios_tokens.push(actor.notification_token)
        end
      end
      audition.save
    end

    if android_tokens.length > 0
      create_notification("android", android_tokens, "Audition Update", "An audition has been updated")
    end
    if ios_tokens.length > 0
      create_notification("ios", ios_tokens, "Audition Update", "An audition has been updated")
    end

    render json: user.projects.find(params[:project_id]).auditions.order(:time), status: 200
  end

  private

  def audition_params
    params.require(:audition).permit(
      :status,
      :response
    )
  end
end
