# == Schema Information
#
# Table name: rooms
#
# id            :ingeger
# title         :string
# messages      :message
# users         :users
# created_at    :datetime
# updated_at    :datetime

class Room
  include Mongoid::Document
  field :title, type: String
  embeds_many  :messages

  # Validations
  validates :title, presence: true
  validates :title, uniqueness: {case_sensitive: false}
end
