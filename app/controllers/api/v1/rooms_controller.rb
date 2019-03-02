module Api
  module V1
    class RoomsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_room, only: [:show, :update, :destroy]

      # GET /rooms
      def index
        @rooms = Room.all
        render json: @rooms
      end

      # GET /rooms/1
      def show
        render :json => {
            :messages => @room.messages.last(20),
            :room => @room.as_json(except: :messages)
          }
      end

      # POST /rooms
      def create
        @room = Room.new(room_params)

        if @room.save
          render json: @room, status: :created, location: @room
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_room
          @room = Room.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def room_params
          params.require(:room).permit(:title)
        end
    end
  end
end
