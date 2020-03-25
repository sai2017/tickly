class Message < ApplicationRecord
  belongs_to :message_room
  belongs_to :user

  enum unread: { unread: true, read: false }
end
