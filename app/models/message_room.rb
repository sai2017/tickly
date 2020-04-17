class MessageRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy
end
