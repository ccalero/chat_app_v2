module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_user, only: [:show, :update, :destroy]


      # POST /users
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.require(:user).permit(:username)
        end
    end
  end
end
