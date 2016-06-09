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
      action = "#{user.name} confirmed."
    elsif params[:audition][:status] == 'TIME'
      action = "#{user.name} requested new time."
    elsif params[:audition][:status] == 'REGR'
      action = "#{user.name} regretted."
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
      director = audition.project.director
      actor = audition.user

      if params[:status] == 'CAST'
        if audition.status == 'CONF'
          audition.response = 'confirm'
          action = "You forwarded confirm to #{director}."
        elsif audition.status == 'TIME'
          audition.response = 'time'
          action = "You forwarded new time to #{director}."
        elsif audition.status == 'REGR'
          audition.response = 'regret'
          action = "You forwarded regret to #{director}."
        end
        audition.histories.create(action: action)

      else
        audition.status = params[:status]

        if params[:status] == 'SENT'
          action = "You sent audition request to #{actor.name}."
        elsif params[:status] == 'SENT+'
          action = "You sent audition request to #{actor.name} with materials."
        elsif params[:status] == 'CONF'
          audition.response = 'confirm'
          action = "You confirmed #{actor.name} to #{director}."
        elsif params[:status] == 'TIME'
          audition.response = 'time'
          action = "You requested a new time for #{actor.name} from #{director}."
        elsif params[:status] == 'REGR'
          audition.response = 'regret'
          action = "You regretted #{actor.name} to #{director}."
        elsif params[:status] == 'CALL'
          action = "You called #{actor.name}."
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
