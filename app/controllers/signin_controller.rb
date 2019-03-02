class SigninController < ApplicationController
  before_action :authorize_access_request!, only: [:destroy]

  def create
    user = User.find_by!(username: params[:username])
    if user
      payload = { user_id: user.id.to_str }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                        value: tokens[:access],
                        httponly: true,
                        secure: Rails.env.production?)
      user.token = tokens[:csrf]
      user.save()
      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: "Cannot find username" }, status: :not_found
  end
end
