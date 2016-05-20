class MessagesController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :create]

  def index
    user = current_user

    if user.role = 'agent'
      @messages = user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).messages
    else
      @messages = user.auditions.find(params[:audition_id]).messages
    end
  end

  def create
    user = current_user

    if user.role = 'agent'
      @messages = user.projects.find(params[:project_id]).auditions.find(params[:audition_id]).messages
    else
      @messages = user.auditions.find(params[:audition_id]).messages
    end

    if @message.create(message_params)
      render "index", status: 200
    else
      render json: { errors: @message.errors }, status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(
      :user_id,
      :body
    )
  end
end
