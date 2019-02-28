# == Schema Information
#
# Table name: messages
#
# id            :ingeger
# content       :string
# messages      :message
# rooms         :room
# created_at    :datetime
# updated_at    :datetime

class Message
  include Mongoid::Document
  field :content, type: String
  # field :created_at, :type => Time, default: Time.now
  field :sender_user, type: String
  embedded_in  :room
  # embedded_in  :user

  # Validations
  validates :content, presence: true
  validates :sender_user, presence: true
  validates :room, presence: true
  # validates :user, presence: true
  # validates :created_at, presence: true

end
