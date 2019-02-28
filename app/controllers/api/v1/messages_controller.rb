module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_message, only: [:show, :update, :destroy]


      # POST /messages.json
      def create
        @message = Message.new(
          message_params
            .merge('room':current_room)
            .merge('sender_user':current_user.username))
        respond_to do |format|
          if @message.save!
            render json: @message, status: :created, location: @message
          else
            render json: @message.errors, status: :unprocessable_entity
          end
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_message
          @message = Message.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def message_params
          params.require(:message).permit(:content, :room, :sender_user)
        end

        def current_room
          Room.find_by(id: params[:message][:room_id])
        end
    end
  end
end
