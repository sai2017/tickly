class CreateMailNotificatoinSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_notificatoin_settings do |t|
      t.boolean :message_flag, null: false, default: true
      t.boolean :like_flag, null: false, default: true
      t.boolean :matching_flag, null: false, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
