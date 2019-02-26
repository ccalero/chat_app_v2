class Message
  include Mongoid::Document
  field :content, type: String
  field :user_id, type: Integer
  field :room_id, type: Integer
end
