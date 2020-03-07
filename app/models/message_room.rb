class MessageRoom < ApplicationRecord
  has_many :messages
  has_many :message_room_users
end
