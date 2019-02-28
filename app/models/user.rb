# == Schema Information
#
# Table name: users
#
# id            :ingeger
# username      :string
# created_at    :datetime
# updated_at    :datetime

class User
  include Mongoid::Document
  field :username, type: String
  # embeds_many :messages

  # Validations
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}
end
