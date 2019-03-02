module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      token = request.params[:token]
      self.current_user = User.find_by(token: token)
    end

  end
end
