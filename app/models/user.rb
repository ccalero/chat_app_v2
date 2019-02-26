class User
  include Mongoid::Document
  field :nick, type: String
end
