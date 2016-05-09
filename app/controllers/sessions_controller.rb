class SessionsController < ActionController::Base
  before_action :authenticate_with_token!, only: [:destroy]

  def create
    user_email = params[:session][:email]
    user_password = params[:session][:password]
    user = user_email.present? && User.find_for_authentication(:email => user_email)

    if !user.nil? && (user.valid_password? user_password)
      sign_in user, store: false
      user.generate_authentication_token!
      user.platform = params[:session][:platform] if params[:session][:platform]
      user.notification_token = params[:session][:notification_token] if params[:session][:notification_token]
      if user.save
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = current_user
    user.generate_authentication_token!
    user.save
    head 204
  end
end
