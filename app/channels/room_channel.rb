class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    room_id = data["room_id"]
    message = data['message']
    room = Room.find_by(id: room_id)

    Message.create! room:room, content: message, sender_user: current_user.username

    ActionCable.server.broadcast "room_channel",{
      message: message,
      room_id: room_id,
      sender_user: current_user.username,
    }
  end
end
