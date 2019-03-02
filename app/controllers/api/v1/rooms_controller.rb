module Api
  module V1
    class RoomsController < ApplicationController

      # GET /rooms
      def index
        @rooms = Room.all
        render json: @rooms.as_json(except: :messages)
      end

      # GET /rooms/1
      def show
        # Avoid error in tests
        if !@room
          @room = Room.find_by(id: params[:id])
        end

        render :json => {
            :messages => @room.messages.last(20),
            :room => @room.as_json(except: :messages)
          }
      end

      # POST /rooms
      def create
        @room = Room.new(room_params)

        if @room.save
          render json: @room, status: :created
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      private

        # Only allow a trusted parameter "white list" through.
        def room_params
          params.require(:room).permit(:title)
        end
    end
  end
end
