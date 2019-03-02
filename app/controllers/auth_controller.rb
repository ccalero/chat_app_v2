class AuthController < ApplicationController
  def login
    @user = User.find_by(username: params[:username])
    if @user
      login_user
    else
      not_found
    end
  end

  def signup
    @user = User.new(user_params)
    if @user.save
      login_user
    else
      render json: { error: @user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  private

  def not_found
    render json: { error: "Cannot find username" }, status: :not_found
  end

  def user_params
    params.permit(:username)
  end

  def login_user
    payload = { user_id: @user.id.to_str }
    session = JWTSessions::Session.new(payload: payload)
    tokens = session.login
    response.set_cookie(JWTSessions.access_cookie,
                      value: tokens[:access],
                      httponly: true,
                      secure: Rails.env.production?)
    @user.token = tokens[:csrf]
    @user.save()
    render json: { csrf: tokens[:csrf] }
  end
end
