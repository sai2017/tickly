class Message < ApplicationRecord
  belongs_to :message_room
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }

  enum unread: { unread: true, read: false }
end
