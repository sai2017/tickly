class CreateMessageRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :message_room_users do |t|
      t.integer :message_room_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
